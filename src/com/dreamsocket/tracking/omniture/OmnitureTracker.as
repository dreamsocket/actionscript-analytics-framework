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
 
 
 
package com.dreamsocket.tracking.omniture 
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.describeType;
	import flash.utils.Dictionary;

	import com.dreamsocket.utils.PropertyStringUtil;	
	import com.dreamsocket.tracking.ITrack;
	import com.dreamsocket.tracking.ITracker;
	import com.dreamsocket.tracking.omniture.OmnitureService;
	import com.dreamsocket.tracking.omniture.OmnitureTrackerConfig;
	import com.dreamsocket.tracking.omniture.OmnitureTrackHandler;
	import com.dreamsocket.tracking.omniture.OmnitureTrackRequest;
	import com.dreamsocket.tracking.omniture.OmnitureTrackLinkRequest;
	
	
	public class OmnitureTracker implements ITracker
	{
		public static var display:DisplayObjectContainer;
		public static const ID:String = "OmnitureTracker";
		
		protected var m_config:OmnitureTrackerConfig;
		protected var m_enabled:Boolean;
		protected var m_service:OmnitureService;
		protected var m_trackHandlers:Dictionary;
		
		public function OmnitureTracker(p_display:DisplayObjectContainer = null)
		{
			super();
			
			this.m_enabled = true;
			this.m_service = new OmnitureService(p_display == null ? OmnitureTracker.display : p_display);
			this.m_trackHandlers = new Dictionary();
		}

		
		public function get config():OmnitureTrackerConfig
		{
			return this.m_config;
		}
		
		
		public function set config(p_value:OmnitureTrackerConfig):void
		{
			if(p_value != this.m_config)
			{
				this.m_config = p_value;
				this.m_service.config = p_value.params;
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
				
				
		public function addTrackHandler(p_ID:String, p_trackHandler:OmnitureTrackHandler):void
		{
			this.m_trackHandlers[p_ID] = p_trackHandler;
		}
		
		
		public function getTrackHandler(p_ID:String):OmnitureTrackHandler
		{
			return this.m_trackHandlers[p_ID] as OmnitureTrackHandler;	
		}
		
		
		public function removeTrackHandler(p_ID:String):void
		{
			delete(this.m_trackHandlers[p_ID]);	
		}	
		
				
		public function track(p_track:ITrack):void
		{
			if(!this.m_enabled) return;
			
			var handler:OmnitureTrackHandler = this.m_config.trackHandlers[p_track.type];
			
			
			if(handler != null && handler.request != null)
			{ 	// has a track handler
				var requestParams:OmnitureParams = new OmnitureParams();
				var handlerParams:OmnitureParams;
				
				if(handler.request.params != null && handler.request.params is OmnitureParams)
				{
					handlerParams = handler.request.params;
					
					var desc:XML = describeType(handlerParams);
					var propNode:XML;
					var props:XMLList = desc..variable;
					var prop:String;
					var val:*;
					
					// instance props
					for each(propNode in props)
					{
						prop = propNode.@name;
						val = handlerParams[prop]; 
						if(val is String && val != null)
						{
							requestParams[prop] = PropertyStringUtil.evalPropertyString(p_track.data, val);
						}
					}					
					// dynamic prop
					for(prop in handlerParams)
					{ 
						requestParams[prop] = PropertyStringUtil.evalPropertyString(p_track.data, handlerParams[prop]);
					}				
				}


				// call correct track method
				if(handler.request is OmnitureTrackLinkRequest)
				{
					var URL:String = PropertyStringUtil.evalPropertyString(p_track.data, handler.request.URL);
					var type:String = PropertyStringUtil.evalPropertyString(p_track.data, handler.request.type);
					var name:String = PropertyStringUtil.evalPropertyString(p_track.data, handler.request.name);					
					
					this.m_service.trackLink(requestParams, URL, type, name);
				}
				else if(handler.request is OmnitureTrackRequest)
				{
					this.m_service.track(requestParams);
				}
			}
		}
	}
}
