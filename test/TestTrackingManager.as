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
	import com.dreamsocket.tracking.google.GoogleTracker;
	import com.dreamsocket.tracking.google.GoogleTrackerConfigXMLDecoder;
	import com.dreamsocket.tracking.omniture.OmnitureTracker;
	import com.dreamsocket.tracking.omniture.OmnitureTrackerConfigXMLDecoder;
	import com.dreamsocket.tracking.url.URLTracker;
	import com.dreamsocket.tracking.url.URLTrackerConfigXMLDecoder;
	import com.dreamsocket.tracking.TrackingManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class TestTrackingManager extends Sprite
	{
		private var m_loader:URLLoader;
		
		
		public function TestTrackingManager()
		{			
			this.m_loader = new URLLoader();
			this.m_loader.addEventListener(Event.COMPLETE, this.onXMLLoaded);
			this.m_loader.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);
			this.m_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);
			this.m_loader.load(new URLRequest("test_tracking_multiple.xml"));
		}


		private function onErrorOccurred(p_event:Event):void
		{
			trace(p_event);
		}
		
		
		private function onXMLLoaded(p_event:Event):void
		{
			var data:XML = new XML(this.m_loader.data);
			
			GoogleTracker.display = this;
			OmnitureTracker.display = this;
			
			// create all trackers
			TrackingManager.addTracker(GoogleTracker.ID, new GoogleTracker());
			TrackingManager.addTracker(OmnitureTracker.ID, new OmnitureTracker());
			TrackingManager.addTracker(URLTracker.ID, new URLTracker());	
			
			// configure all trackers
			OmnitureTracker(TrackingManager.getTracker(OmnitureTracker.ID)).config = new OmnitureTrackerConfigXMLDecoder().decode(data.omniture[0]);
			GoogleTracker(TrackingManager.getTracker(GoogleTracker.ID)).config = new GoogleTrackerConfigXMLDecoder().decode(data.google[0]);
			URLTracker(TrackingManager.getTracker(URLTracker.ID)).config = new URLTrackerConfigXMLDecoder().decode(data.URL[0]);
			
			// perform tracks
			TrackingManager.track(new Track("track1", "test string"));
			TrackingManager.track(new Track("track2", {id:"testid"}));
			TrackingManager.track(new Track("track3", "test string"));
		}
	}
}
