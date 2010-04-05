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
	import flash.events.MouseEvent;
	import com.dreamsocket.analytics.Track;
	import com.dreamsocket.analytics.omniture.OmnitureTrackerConfig;
	import com.dreamsocket.analytics.omniture.OmnitureTrackerConfigXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureTracker;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class TestOmnitureMediaTracking extends Sprite
	{
		private var m_loader:URLLoader;
		private var m_tracker:OmnitureTracker;
		
		public var requestBtn:Object;
		public var startBtn:Object;
		public var playBtn:Object;
		public var pauseBtn:Object;
		public var closeBtn:Object;
		
		public function TestOmnitureMediaTracking()
		{
			this.m_loader = new URLLoader();
			this.m_loader.addEventListener(Event.COMPLETE, this.onXMLLoaded);
			this.m_loader.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);
			this.m_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);
			this.m_loader.load(new URLRequest("test_omniture_media.xml"));
			
			this.requestBtn.addEventListener(MouseEvent.CLICK, this.onRequestClicked);
			this.startBtn.addEventListener(MouseEvent.CLICK, this.onStartClicked);
			this.playBtn.addEventListener(MouseEvent.CLICK, this.onPlayClicked);
			this.pauseBtn.addEventListener(MouseEvent.CLICK, this.onPauseClicked);
			this.closeBtn.addEventListener(MouseEvent.CLICK, this.onCloseClicked);
		}

		
		private function onErrorOccurred(p_event:Event):void
		{
			trace(p_event);
		}
		
		
		private function onRequestClicked(p_event:MouseEvent):void
		{
			this.m_tracker.track(new Track("mediaRequested", {duration:120, position:0, title:"testid"}));
		}
		
		
		private function onStartClicked(p_event:MouseEvent):void
		{
			this.m_tracker.track(new Track("mediaStarted", {duration:120, position:0, title:"testid"}));
		}
		
		
		private function onPlayClicked(p_event:MouseEvent):void
		{
			this.m_tracker.track(new Track("mediaPlaying", {duration:120, position:30, title:"testid"}));
		}				
		
		
		private function onPauseClicked(p_event:MouseEvent):void
		{
			this.m_tracker.track(new Track("mediaPaused", {duration:120, position:30, title:"testid"}));
		}	
		
		
		private function onCloseClicked(p_event:MouseEvent):void
		{
			this.m_tracker.track(new Track("mediaClosed", {duration:120, position:0, title:"testid"}));
		}	
		
						
		private function onXMLLoaded(p_event:Event):void
		{
			var config:OmnitureTrackerConfig = new OmnitureTrackerConfigXMLDecoder().decode(new XML(this.m_loader.data));
			
			this.m_tracker = new OmnitureTracker(this.stage);
			this.m_tracker.config = config;
			
			this.m_tracker.track(new Track("mediaRequested", {duration:120, title:"testid", position:0}));
			this.m_tracker.track(new Track("mediaStarted", {duration:120, title:"testid", position:0}));
			
			this.m_tracker.track(new Track("mediaPaused", {position:30, title:"testid"}));
			this.m_tracker.track(new Track("mediaPlaying", {position:30, title:"testid"}));
			
			this.m_tracker.track(new Track("mediaClosed", {position:110, title:"testid"}));
		}
	}
}