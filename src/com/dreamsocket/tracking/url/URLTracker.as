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
 
 
package com.dreamsocket.tracking.url 
{
	import flash.utils.Dictionary;

	import com.dreamsocket.utils.PropertyStringUtil;	
	import com.dreamsocket.tracking.ITrack;
	import com.dreamsocket.tracking.ITracker;
	import com.dreamsocket.tracking.url.URLTrackerConfig;
	import com.dreamsocket.tracking.url.URLTrackHandler;
	import com.dreamsocket.utils.HTTPUtil;
	
	
	public class URLTracker implements ITracker
	{
		public static const ID:String = "URLTracker";
		
				
		protected var m_config:URLTrackerConfig;
		protected var m_enabled:Boolean;
		protected var m_trackHandlers:Dictionary;
		
		
		public function URLTracker()
		{
			super();
			
			this.m_config = new URLTrackerConfig();
			this.m_enabled = true;
			this.m_trackHandlers = new Dictionary();
		}

		
		public function get config():URLTrackerConfig
		{
			return this.m_config;
		}
		
		
		public function set config(p_value:URLTrackerConfig):void
		{
			if(p_value != this.m_config)
			{
				this.m_config = p_value;
				this.m_enabled = p_value.enabled;
				this.m_trackHandlers = p_value.trackHandlers;
			}
		}
		
		
		public function get enabled():Boolean
		{
			return this.m_enabled;
		}	
		
				
		public function set enabled(p_enabled:Boolean):void
		{
			this.m_enabled = p_enabled;
		}
		
		
		public function addTrackHandler(p_ID:String, p_trackHandler:URLTrackHandler):void
		{
			this.m_trackHandlers[p_ID] = p_trackHandler;
		}
		
		
		public function getTrackHandler(p_ID:String):URLTrackHandler
		{
			return this.m_trackHandlers[p_ID] as URLTrackHandler;	
		}
		
		
		public function removeTrackHandler(p_ID:String):void
		{
			delete(this.m_trackHandlers[p_ID]);	
		}	
		
						
		public function track(p_track:ITrack):void
		{
			if(!this.m_enabled) return;
			
			var handler:URLTrackHandler = this.m_trackHandlers[p_track.type];
			
			if(handler != null)
			{ // has the track type
				var URLs:Array = handler.URLs;
				var i:uint = URLs.length;
				
				while(i--)
				{ 
					HTTPUtil.pingURL(PropertyStringUtil.evalPropertyString(p_track.data, URLs[i]));
				}
			}
		}
	}
}