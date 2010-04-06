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

	import com.dreamsocket.analytics.ITracker;
	import com.dreamsocket.analytics.TrackerModuleLoaderParams;

	public class TrackerModuleLoaderEvent extends Event
	{
		public static const MODULE_LOADED:String = "moduleLoaded";
		public static const MODULE_FAILED:String = "moduleFailed";
	
		private var m_params:TrackerModuleLoaderParams;
		private var m_tracker:ITracker;
	
	
		public function TrackerModuleLoaderEvent(p_eventType:String, p_params:TrackerModuleLoaderParams, p_tracker:ITracker = null, p_bubbles:Boolean = false, p_cancelable:Boolean = false) 
		{
			super(p_eventType, p_bubbles, p_cancelable);
			this.m_params = p_params;
			this.m_tracker = p_tracker;
		}
	
	
		public function get params():TrackerModuleLoaderParams 
		{
			return this.m_params;
		}
	
	
		public function get tracker():ITracker 
		{
			return this.m_tracker;
		}
		      
		      
		override public function clone():Event 
		{
			return new TrackerModuleLoaderEvent(this.type, this.params, this.tracker, this.bubbles, this.cancelable);
		}
		
		
		override public function toString():String
		{
			return this.formatToString("TrackerModuleLoaderEvent", "type", "bubbles", "eventPhase");	
		}			
	}
}