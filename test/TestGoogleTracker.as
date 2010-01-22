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
	import com.dreamsocket.tracking.Track;
	import com.dreamsocket.tracking.google.GoogleTrackerConfig;
	import com.dreamsocket.tracking.google.GoogleTrackerConfigXMLDecoder;
	import com.dreamsocket.tracking.google.GoogleTracker;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class TestGoogleTracker extends Sprite
	{
		private var m_loader:URLLoader;
		private var m_tracker:GoogleTracker;
		
		public function TestGoogleTracker()
		{
			this.m_loader = new URLLoader();
			this.m_loader.addEventListener(Event.COMPLETE, this.onXMLLoaded);
			this.m_loader.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);
			this.m_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);
			this.m_loader.load(new URLRequest("test_tracking_google.xml"));
		}


		private function onErrorOccurred(p_event:Event):void
		{
			trace(p_event);
		}
		
		
		private function onXMLLoaded(p_event:Event):void
		{
			var config:GoogleTrackerConfig = new GoogleTrackerConfigXMLDecoder().decode(new XML(this.m_loader.data));
			
			this.m_tracker = new GoogleTracker(this);
			this.m_tracker.config = config;
			
			this.m_tracker.track(new Track("track1", "test string"));
			this.m_tracker.track(new Track("track2", {id:"testid"}));
			this.m_tracker.track(new Track("track3", "test string"));
		}
	}
}
