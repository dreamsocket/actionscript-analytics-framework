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
 
 
package com.dreamsocket.tracking.google 
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	import com.dreamsocket.utils.PropertyStringUtil;	
	import com.dreamsocket.tracking.ITrack;
	import com.dreamsocket.tracking.ITracker;
	import com.dreamsocket.tracking.google.GoogleTrackerConfig;
	import com.dreamsocket.tracking.google.GoogleTrackEventRequest;
	import com.dreamsocket.tracking.google.GoogleTrackPageViewRequest;
	import com.dreamsocket.tracking.google.GoogleTrackHandler;
	
	import com.google.analytics.GATracker;
	
	
	public class GoogleTracker implements ITracker
	{
		public static var display:DisplayObject;
		
		public static const ID:String = "GoogleTracker";
		
		protected var m_config:GoogleTrackerConfig;
		protected var m_display:DisplayObject;
		protected var m_enabled:Boolean;
		protected var m_service:GATracker;
		protected var m_trackHandlers:Dictionary;
		
		public function GoogleTracker(p_display:DisplayObject = null)
		{
			super();
			
			this.m_config = new GoogleTrackerConfig();
			this.m_display = p_display;
			this.m_enabled = true;
			this.m_trackHandlers = new Dictionary();
		}

		
		public function get config():GoogleTrackerConfig
		{
			return this.m_config;
		}
		
		
		public function set config(p_value:GoogleTrackerConfig):void
		{
			if(p_value != this.m_config)
			{
				this.m_config = p_value;
				
				try
				{
					this.m_service = new GATracker(this.m_display == null ? GoogleTracker.display : this.m_display, p_value.account, p_value.trackingMode, p_value.visualDebug);
				}
				catch(error:Error)
				{
					trace(error);	
				}
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
				
				
		public function addTrackHandler(p_ID:String, p_trackHandler:GoogleTrackHandler):void
		{
			this.m_trackHandlers[p_ID] = p_trackHandler;
		}
		
		
		public function destroy():void
		{
		}
		
		
		public function getTrackHandler(p_ID:String):GoogleTrackHandler
		{
			return this.m_trackHandlers[p_ID] as GoogleTrackHandler;	
		}
		
		
		public function removeTrackHandler(p_ID:String):void
		{
			delete(this.m_trackHandlers[p_ID]);	
		}	
		
				
		public function track(p_track:ITrack):void
		{
			if(!this.m_enabled || this.m_service == null) return;
			
			var handler:GoogleTrackHandler = this.m_config.trackHandlers[p_track.type];
			
			
			if(handler != null)
			{ 	// has a track handler
				// call correct track method
				if(handler.request is GoogleTrackEventRequest)
				{
					var eventRequest:GoogleTrackEventRequest = GoogleTrackEventRequest(handler.request);
					var category:String = PropertyStringUtil.evalPropertyString(p_track.data, eventRequest.category);
					var action:String = PropertyStringUtil.evalPropertyString(p_track.data, eventRequest.action);
					var label:String = PropertyStringUtil.evalPropertyString(p_track.data, eventRequest.label);
					var value:Number = Number(PropertyStringUtil.evalPropertyString(p_track.data, eventRequest.value)); 	
				
					try
					{
						this.m_service.trackEvent(category, action, label, value);
					}
					catch(error:Error)
					{
						trace(error);
					}
				}
				else if(handler.request is GoogleTrackPageViewRequest)
				{
					var viewRequest:GoogleTrackPageViewRequest = GoogleTrackPageViewRequest(handler.request);
					
					try
					{
						this.m_service.trackPageview(PropertyStringUtil.evalPropertyString(p_track.data, viewRequest.URL));
					}
					catch(error:Error)
					{
						trace(error);
					}
				}
			}
		}
	}
}
