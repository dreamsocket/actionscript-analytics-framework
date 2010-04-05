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
 
 
package com.dreamsocket.analytics.google 
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	import com.dreamsocket.analytics.ITrack;
	import com.dreamsocket.analytics.ITracker;
	import com.dreamsocket.analytics.google.GoogleBatchParamsMapper;
	import com.dreamsocket.analytics.google.GoogleSingleton;
	import com.dreamsocket.analytics.google.GoogleTrackerConfig;
	import com.dreamsocket.analytics.google.GoogleTrackEventParamsMapper;
	import com.dreamsocket.analytics.google.GoogleTrackPageViewParamsMapper;
	import com.dreamsocket.analytics.google.GoogleTrackHandler;
	import com.dreamsocket.analytics.google.GoogleTrackType;
	
	import com.google.analytics.GATracker;
	
	
	public class GoogleTracker implements ITracker
	{
		public static const ID:String = "GoogleTracker";
		
		protected var m_config:GoogleTrackerConfig;
		protected var m_enabled:Boolean;
		protected var m_service:GATracker;
		protected var m_handlers:Dictionary;
		protected var m_functions:Dictionary;
		protected var m_paramMappers:Dictionary;
		
		public function GoogleTracker(p_stage:Stage = null)
		{
			super();
			
			GoogleSingleton.stage = p_stage;
			this.m_config = new GoogleTrackerConfig();
			this.m_enabled = true;
			this.m_handlers = new Dictionary();
			
			this.m_functions = new Dictionary();
			this.m_functions[GoogleTrackType.TRACK_EVENT] = this.trackEvent;
			this.m_functions[GoogleTrackType.TRACK_PAGE_VIEW] = this.trackPageview;
			this.m_functions[GoogleTrackType.BATCH] = this.batch;
			
			this.m_paramMappers = new Dictionary();
			this.m_paramMappers[GoogleTrackType.TRACK_EVENT] = new GoogleTrackEventParamsMapper();
			this.m_paramMappers[GoogleTrackType.TRACK_PAGE_VIEW] = new GoogleTrackPageViewParamsMapper();
			this.m_paramMappers[GoogleTrackType.BATCH] = new GoogleBatchParamsMapper();				
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
					this.m_service = GoogleSingleton.create(p_value.account, p_value.trackingMode, p_value.visualDebug);
				}
				catch(error:Error)
				{
					trace(error);	
				}
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
			return GoogleTracker.ID;
		}
		
				
		public function addTrackHandler(p_ID:String, p_handler:GoogleTrackHandler):void
		{
			this.m_handlers[p_ID] = p_handler;
		}
		
		
		public function destroy():void
		{
		}
		
		
		public function getTrackHandler(p_ID:String):GoogleTrackHandler
		{
			return this.m_handlers[p_ID] as GoogleTrackHandler;	
		}
		
		
		public function removeTrackHandler(p_ID:String):void
		{
			delete(this.m_handlers[p_ID]);	
		}	
		
				
		public function track(p_track:ITrack):void
		{
			if(!this.m_enabled || this.m_service == null) return;
			
			var handler:GoogleTrackHandler = this.m_config.handlers[p_track.ID];
	
			if(handler == null) return;
			this.doTrack(handler, p_track.data);	
		}
		
		
		protected function doTrack(p_handler:GoogleTrackHandler, p_data:*):void
		{
			if(p_handler.params != null && this.m_paramMappers[p_handler.type] != null && this.m_functions[p_handler.type])
			{ 	// has a track handler
				try
				{
					this.m_functions[p_handler.type](this.m_paramMappers[p_handler.type].map(p_handler.params, p_data));
				}
				catch(error:Error)
				{
					trace(error);
				}
			}			
		}


		protected function batch(p_params:GoogleBatchParams):void
		{
			var i:uint = 0;
			var len:uint = p_params.handlers.length;
			while(i < len)
			{
				this.doTrack(GoogleTrackHandler(p_params.handlers[i++]), p_params.data);
			}
		}
				
		
		protected function trackEvent(p_params:GoogleTrackEventParams):void
		{
			this.m_service.trackEvent(p_params.category, p_params.action, p_params.label, Number(p_params.value));
		}
		
		
		protected function trackPageview(p_params:GoogleTrackPageViewParams):void
		{
			this.m_service.trackPageview(p_params.URL);
		}		
	}
}
