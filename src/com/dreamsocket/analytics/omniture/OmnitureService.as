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
	import flash.utils.describeType;
	import flash.utils.Dictionary;	

	import com.dreamsocket.analytics.omniture.OmnitureParams;	
	import com.dreamsocket.analytics.omniture.OmnitureSingleton;
	import com.dreamsocket.analytics.omniture.OmnitureMediaCloseParams;
	import com.dreamsocket.analytics.omniture.OmnitureMediaOpenParams;
	import com.dreamsocket.analytics.omniture.OmnitureMediaPlayParams;
	import com.dreamsocket.analytics.omniture.OmnitureMediaStopParams;
	import com.dreamsocket.analytics.omniture.OmnitureMediaTrackParams;
	import com.dreamsocket.analytics.omniture.OmnitureTrackParams;
	import com.dreamsocket.analytics.omniture.OmnitureTrackLinkParams;
	import com.dreamsocket.analytics.omniture.OmnitureTrackType;
	
	import com.omniture.ActionSource;


	public class OmnitureService
	{
		protected var m_config:OmnitureParams;
		protected var m_enabled:Boolean;
		protected var m_lastTrackParams:OmnitureParams;
		protected var m_tracker:ActionSource;
		protected var m_functions:Dictionary;

		
		public function OmnitureService(p_stage:Stage = null)
		{
			this.m_tracker = OmnitureSingleton.create(p_stage);
			this.m_enabled = true;
			
			this.m_functions = new Dictionary();
			this.m_functions[OmnitureTrackType.MEDIA_CLOSE] = this.trackMediaClose;
			this.m_functions[OmnitureTrackType.MEDIA_OPEN] = this.trackMediaOpen;
			this.m_functions[OmnitureTrackType.MEDIA_PLAY] = this.trackMediaPlay;
			this.m_functions[OmnitureTrackType.MEDIA_STOP] = this.trackMediaStop;
			this.m_functions[OmnitureTrackType.MEDIA_TRACK] = this.trackMedia;
			this.m_functions[OmnitureTrackType.TRACK] = this.trackEvent;
			this.m_functions[OmnitureTrackType.TRACK_LINK] = this.trackLink;
		}

		
		public function get config():OmnitureParams
		{
			return this.m_config;
		}
		
		
		public function set config(p_config:OmnitureParams):void
		{
			if(p_config != this.m_config)
			{
				this.mergeParams(p_config, this.m_tracker, this.m_config == null ? p_config : this.m_config);
				this.mergeParams(p_config.Media, this.m_tracker.Media, this.m_config == null ? p_config.Media : this.m_config.Media);
				this.m_config = p_config;
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

		
		public function destroy():void
		{
			this.m_tracker = null;
			this.m_config = null;
			this.m_lastTrackParams = null;
		}


		public function track(p_type:String, p_params:Object):void
		{
			if(!this.m_enabled) return;

			this.setParams(p_params.params);
			
			try
			{
				this.m_functions[p_type](p_params);	
			}
			catch(error:Error)
			{
				trace(error);
			}
			
			this.resetParams();
		}
		
		
		protected function trackEvent(p_params:OmnitureTrackParams):void
		{
			this.m_tracker.track();
		}

		
		protected function trackLink(p_params:OmnitureTrackLinkParams):void
		{
			this.m_tracker.trackLink(p_params.URL, p_params.type, p_params.name);
		}
		
		
		protected function trackMedia(p_params:OmnitureMediaTrackParams):void
		{
			this.m_tracker.Media.track(p_params.mediaName);
		}	
		

		protected function trackMediaOpen(p_params:OmnitureMediaOpenParams):void
		{
			this.m_tracker.Media.open(p_params.mediaName, Number(p_params.mediaLength), p_params.mediaPlayerName);
		}		
		
		
		protected function trackMediaClose(p_params:OmnitureMediaCloseParams):void
		{
			this.m_tracker.Media.close(p_params.mediaName);
		}		
		
		
		protected function trackMediaPlay(p_params:OmnitureMediaPlayParams):void
		{
			this.m_tracker.Media.play(p_params.mediaName, Number(p_params.mediaOffset));
		}						


		protected function trackMediaStop(p_params:OmnitureMediaStopParams):void
		{
			this.m_tracker.Media.stop(p_params.mediaName, Number(p_params.mediaOffset));
		}	
		

		protected function mergeParams(p_newValues:Object, p_destination:Object, p_oldValues:Object):void
		{
			var desc:XML = describeType(p_newValues);
			var propNode:XML;
			var props:XMLList = desc..variable;
			var type:String;
			var name:String;
			var oldVal:*;
			var newVal:*;
			
			// instance props
			for each(propNode in props)
			{
				name = propNode.@name;
				type = propNode.@type;
				oldVal = p_oldValues[name]; 
				newVal = p_newValues[name];
				if(oldVal is String && oldVal != null)
				{
					p_destination[name] = newVal;
				}
				else if(oldVal is Number && !isNaN(oldVal))
				{
					p_destination[name] = newVal;
				}
				else if(oldVal is Boolean && oldVal)
				{
					p_destination[name] = newVal;
				}	
			}	
			
			// dynamic props
			for(name in p_oldValues)
			{				
				oldVal = p_oldValues[name]; 
				newVal = p_newValues[name];
				if(oldVal is String && oldVal != null)
				{
					p_destination[name] = newVal;
				}
				else if(oldVal is Number && !isNaN(oldVal))
				{
					p_destination[name] = newVal;
				}
				else if(oldVal is Boolean && oldVal)
				{
					p_destination[name] = newVal;
				}				
			}
		}

		
		protected function resetParams():void
		{
			if(this.m_lastTrackParams == null) return;
			
			this.mergeParams(this.m_config, this.m_tracker, this.m_lastTrackParams);
			this.mergeParams(this.m_config.Media, this.m_tracker.Media, this.m_lastTrackParams.Media);			
		}
		
		
		protected function setParams(p_params:OmnitureParams):void
		{
			this.m_lastTrackParams = p_params;
			this.mergeParams(p_params, this.m_tracker, p_params);
			this.mergeParams(p_params.Media, this.m_tracker.Media, p_params.Media);
		}
	}
}
