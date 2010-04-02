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
 
package  
{
	import com.dreamsocket.analytics.ITracker;
	import com.dreamsocket.analytics.Track;
	import com.dreamsocket.analytics.TrackerManager;
	import com.dreamsocket.analytics.TrackerModuleParams;
	import com.dreamsocket.analytics.ITrackerModule;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class TestTrackerModule extends Sprite
	{
		private var m_configURL:String;
		private var m_configLoader:URLLoader;
		private var m_moduleURL:String;
		private var m_moduleLoader:Loader;

		public function TestTrackerModule()
		{
			this.m_configURL = "test_tracking_javascript.xml";
			this.m_moduleURL = "../bin/daf_javascript.swf";
			
			this.loadConfig();
		}

		
		private function loadConfig():void
		{
			this.m_configLoader = new URLLoader();
			this.m_configLoader.addEventListener(Event.COMPLETE, this.onConfigLoaded);
			this.m_configLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);
			this.m_configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);
			this.m_configLoader.load(new URLRequest(this.m_configURL));			
		}
		
		
		private function loadModule():void
		{
			this.m_moduleLoader = new Loader();
			this.m_moduleLoader.contentLoaderInfo.addEventListener(Event.INIT, this.onModuleLoaded);
			this.m_moduleLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);
			this.m_moduleLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);
			this.m_moduleLoader.load(new URLRequest(this.m_moduleURL));			
		}		
		
		
		private function runTest():void
		{
			var params:TrackerModuleParams = new TrackerModuleParams();
			
			params.stage = this.stage;
			params.config = new XML(this.m_configLoader.data);
			
			var module:ITracker = ITrackerModule(this.m_moduleLoader.content).getTracker(params);
			
			TrackerManager.addTracker("test", module);
			
			TrackerManager.track(new Track("track1", "test string"));
			TrackerManager.track(new Track("track2", {id:"testid"}));
			TrackerManager.track(new Track("track3", "test string"));			
		}
		

		private function onErrorOccurred(p_event:Event):void
		{
			trace(p_event);
		}
		
		
		private function onConfigLoaded(p_event:Event):void
		{
			this.loadModule();
		}
		
		
		private function onModuleLoaded(p_event:Event):void
		{
			this.runTest();
		}		
	}
}
