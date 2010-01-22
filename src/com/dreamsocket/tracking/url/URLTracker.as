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