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
			
			this.m_config = new OmnitureTrackerConfig();
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
