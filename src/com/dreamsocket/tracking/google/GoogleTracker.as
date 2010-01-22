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
