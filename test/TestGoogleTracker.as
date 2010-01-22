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
