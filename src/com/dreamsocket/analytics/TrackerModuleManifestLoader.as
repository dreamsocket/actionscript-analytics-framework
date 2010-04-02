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
	import flash.display.Stage;
	import flash.events.IOErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;

	import com.dreamsocket.analytics.ITrackerModule;
	import com.dreamsocket.analytics.TrackerModuleLoaderQueue;
	import com.dreamsocket.analytics.TrackerModuleManifestXMLDecoder;
	
	
	public class TrackerModuleManifestLoader extends EventDispatcher
	{
		protected var m_configLoader:URLLoader;
		protected var m_decoder:TrackerModuleManifestXMLDecoder;
		protected var m_moduleLoader:TrackerModuleLoaderQueue;
		
		public function TrackerModuleManifestLoader()
		{
			this.m_decoder = new TrackerModuleManifestXMLDecoder();
		}
		
		
		public function set stage(p_value:Stage):void
		{
			this.m_decoder.stage = p_value;
		}
		
				
		public function addModuleDefinition(p_ID:String, p_module:ITrackerModule):void
		{
			this.m_decoder.addModuleDefinition(p_ID, p_module);
		}

		
		public function destroy():void
		{	
			if(this.m_configLoader)
			{
				this.m_configLoader.removeEventListener(Event.COMPLETE, this.onConfigLoaded);
				this.m_configLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);
				this.m_configLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);
				try
				{
					this.m_configLoader.close();
				}
				catch(error:Error){}
				
				this.m_configLoader = null;
			}
			if(this.m_moduleLoader)
			{
				this.m_moduleLoader.removeEventListener(Event.COMPLETE, this.onModulesLoaded);
				this.m_moduleLoader.destroy();
			
				this.m_moduleLoader = null;
			}
						
		}

		
		public function load(p_URL:String):void
		{
			this.destroy();
			
			this.m_configLoader = new URLLoader();
			this.m_configLoader.addEventListener(Event.COMPLETE, this.onConfigLoaded);
			this.m_configLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);
			this.m_configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);	
			
			try
			{		
				this.m_configLoader.load(new URLRequest(p_URL));
			}
			catch(error:Error)
			{
				this.dispatchError(error.message);
			}
		}
		

		protected function dispatchError(p_message:String):void
		{
			this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, p_message));
		}

		
		protected function onConfigLoaded(p_event:Event):void
		{
			try
			{
				this.m_moduleLoader = new TrackerModuleLoaderQueue();
				this.m_moduleLoader.addEventListener(Event.COMPLETE, this.onModulesLoaded);
				this.m_moduleLoader.manifest = this.m_decoder.decode(new XML(this.m_configLoader.data));
				this.m_moduleLoader.load();
				
			}
			catch(error:Error)
			{
				this.dispatchError(error.message);
			}
		}


		protected function onModulesLoaded(p_event:Event):void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		protected function onErrorOccurred(p_event:ErrorEvent):void
		{
			this.dispatchError(p_event.text);
		}
	}
}