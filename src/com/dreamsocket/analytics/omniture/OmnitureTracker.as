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
 
 
package com.dreamsocket.analytics.omniture 
{
	import flash.display.Stage;
	import flash.utils.Dictionary;

	import com.dreamsocket.analytics.ITrack;
	import com.dreamsocket.analytics.ITracker;
	import com.dreamsocket.analytics.omniture.OmnitureService;
	import com.dreamsocket.analytics.omniture.OmnitureTrackerConfig;
	import com.dreamsocket.analytics.omniture.OmnitureTrackHandler;
	import com.dreamsocket.analytics.omniture.OmnitureTrackType;
	import com.dreamsocket.analytics.omniture.OmnitureMediaCloseParamsMapper;
	import com.dreamsocket.analytics.omniture.OmnitureMediaOpenParamsMapper;
	import com.dreamsocket.analytics.omniture.OmnitureMediaPlayParamsMapper;
	import com.dreamsocket.analytics.omniture.OmnitureMediaStopParamsMapper;
	import com.dreamsocket.analytics.omniture.OmnitureMediaTrackParamsMapper;
	import com.dreamsocket.analytics.omniture.OmnitureTrackParamsMapper;
	import com.dreamsocket.analytics.omniture.OmnitureTrackLinkParamsMapper;
	
	public class OmnitureTracker implements ITracker
	{
		public static const ID:String = "OmnitureTracker";
		
		protected var m_config:OmnitureTrackerConfig;
		protected var m_enabled:Boolean;
		protected var m_service:OmnitureService;
		protected var m_handlers:Dictionary;
		protected var m_paramMappers:Dictionary;
		
		public function OmnitureTracker(p_stage:Stage = null)
		{
			super();
			
			this.m_config = new OmnitureTrackerConfig();
			this.m_enabled = true;
			this.m_service = new OmnitureService(p_stage);
			
			this.m_handlers = new Dictionary();
			
			this.m_paramMappers = new Dictionary();
			this.m_paramMappers[OmnitureTrackType.MEDIA_CLOSE] = new OmnitureMediaCloseParamsMapper();
			this.m_paramMappers[OmnitureTrackType.MEDIA_OPEN] = new OmnitureMediaOpenParamsMapper();
			this.m_paramMappers[OmnitureTrackType.MEDIA_PLAY] = new OmnitureMediaPlayParamsMapper();
			this.m_paramMappers[OmnitureTrackType.MEDIA_STOP] = new OmnitureMediaStopParamsMapper();
			this.m_paramMappers[OmnitureTrackType.MEDIA_TRACK] = new OmnitureMediaTrackParamsMapper();
			this.m_paramMappers[OmnitureTrackType.TRACK] = new OmnitureTrackParamsMapper();
			this.m_paramMappers[OmnitureTrackType.TRACK_LINK] = new OmnitureTrackLinkParamsMapper();
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
				this.m_handlers = p_value.handlers;
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
				
		
		public function get ID():String
		{			
			return OmnitureTracker.ID;
		}
		
						
		public function addTrackHandler(p_ID:String, p_handler:OmnitureTrackHandler):void
		{
			this.m_handlers[p_ID] = p_handler;
		}
		
		
		public function getTrackHandler(p_ID:String):OmnitureTrackHandler
		{
			return this.m_handlers[p_ID] as OmnitureTrackHandler;	
		}
		
		
		public function removeTrackHandler(p_ID:String):void
		{
			delete(this.m_handlers[p_ID]);	
		}	
		
				
		public function track(p_track:ITrack):void
		{
			if(!this.m_enabled) return;
			
			var handler:OmnitureTrackHandler = this.m_config.handlers[p_track.type];

			if(handler != null && handler.params != null && this.m_paramMappers[handler.type] != null)
			{ 	// has a track handler
				this.m_service.track(handler.type, this.m_paramMappers[handler.type].map(handler.params, p_track.data));
			}
		}
	}
}
