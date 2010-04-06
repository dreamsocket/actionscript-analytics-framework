/**
* Dreamsocket, Inc.
* http://dreamsocket.com
* Copyright  2010 Dreamsocket, Inc.
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
**/
 
package com.dreamsocket.analytics
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import com.dreamsocket.analytics.TrackerModuleLoader;
	import com.dreamsocket.analytics.TrackerModuleLoaderEvent;
	import com.dreamsocket.analytics.TrackerModuleLoaderParams;
	
	
	public class TrackerModuleLoaderQueue extends EventDispatcher
	{
		private var m_manifest:Array;
		private var m_moduleLoader:TrackerModuleLoader;

		public function TrackerModuleLoaderQueue()
		{
			this.m_manifest = [];
			this.m_moduleLoader = new TrackerModuleLoader();
			this.m_moduleLoader.addEventListener(TrackerModuleLoaderEvent.MODULE_LOADED, this.onModuleLoaded);
			this.m_moduleLoader.addEventListener(TrackerModuleLoaderEvent.MODULE_FAILED, this.onModuleFailed);
		}
		
		
		public function set manifest(p_value:Array):void
		{
			this.m_manifest = p_value;
		}

		
		public function add(p_params:TrackerModuleLoaderParams):void
		{
			this.m_manifest.push(p_params);	
		}
		
				
		public function destroy():void
		{
			this.m_moduleLoader.destroy();
			this.m_manifest.slice();
		}
	
		
		public function load():void
		{
			var params:TrackerModuleLoaderParams = TrackerModuleLoaderParams(this.m_manifest.shift());
			
			if(params)
			{
				this.m_moduleLoader.load(params);
			}
			else
			{
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		
		private function onModuleFailed(p_event:TrackerModuleLoaderEvent):void
		{
			trace(p_event);
			this.load();
		}
		
		
		private function onModuleLoaded(p_event:TrackerModuleLoaderEvent):void
		{
			TrackerManager.addTracker(p_event.tracker.ID, p_event.tracker);
			this.load();
		}		
	}
}
