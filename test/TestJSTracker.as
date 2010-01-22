/**
 * Dreamsocket
 *  
 * Copyright 2009 Dreamsocket.
 * All Rights Reserved.  
 *
 * This software (the "Software") is the property of Dreamsocket and is protected by U.S. and
 * international intellectual property laws. No license is granted with respect to the
 * software and users may not, among other things, reproduce, prepare derivative works
 * of, modify, distribute, sublicense, reverse engineer, disassemble, remove, decompile,
 * or make any modifications of the Software without written permission from Dreamsocket.
 * Further, Dreamsocket does not authorize any user to remove or alter any trademark, logo,
 * copyright or other proprietary notice, legend, symbol, or label in the Software.
 * This notice is not intended to, and shall not, limit any rights Dreamsocket has under
 * applicable law.
 *  
 */
 
 
 
package  
{
	import flash.utils.Dictionary;

	import com.dreamsocket.tracking.Track;
	import com.dreamsocket.tracking.js.JSTrackerConfig;
	import com.dreamsocket.tracking.js.JSMethodCall;
	import com.dreamsocket.tracking.js.JSTrackerConfigXMLDecoder;
	import com.dreamsocket.tracking.js.JSTracker;
	import com.dreamsocket.tracking.js.JSTrackHandler;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class TestJSTracker extends Sprite
	{
		private var m_loader:URLLoader;
		private var m_tracker:JSTracker;
		
		public function TestJSTracker()
		{
			//this.m_loader = new URLLoader();
			//this.m_loader.addEventListener(Event.COMPLETE, this.onXMLLoaded);
			//this.m_loader.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);
			//this.m_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);
			//this.m_loader.load(new URLRequest("test_tracking_omniture.xml"));
			
			var config:JSTrackerConfig = new JSTrackerConfig();
			var trackHandler:JSTrackHandler;
			
			this.m_tracker = new JSTracker();
			this.m_tracker.config = config;
			
			trackHandler = new JSTrackHandler();
			trackHandler.ID = "track3";
			trackHandler.methodCalls = [new JSMethodCall("doRandomThing", [1, 2, "3...{data.id}"])];
			
			config.trackHandlers["track2"] = trackHandler; 

			
			this.m_tracker.track(new Track("track1", "test string1"));
			this.m_tracker.track(new Track("track2", {id:"testid"}));
			this.m_tracker.track(new Track("track3", "test string3"));			
		}


		private function onErrorOccurred(p_event:Event):void
		{
			trace(p_event);
		}
		
		
		private function onXMLLoaded(p_event:Event):void
		{

		}
	}
}
