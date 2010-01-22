/**
 * Dreamsocket, Inc.
 *
 * Copyright  2009 Dreamsocket, Inc..
 * All Rights Reserved.
 *
 * This software (the "Software") is the property of Dreamsocket, Inc. and is protected by U.S. and
 * international intellectual property laws. No license is granted with respect to the
 * software and users may not, among other things, reproduce, prepare derivative works
 * of, modify, distribute, sublicense, reverse engineer, disassemble, remove, decompile,
 * or make any modifications of the Software without written permission from Dreamsocket, Inc..
 * Further, Dreamsocket, Inc. does not authorize any user to remove or alter any trademark, logo,
 * copyright or other proprietary notice, legend, symbol, or label in the Software.
 * This notice is not intended to, and shall not, limit any rights Dreamsocket, Inc. has under
 * applicable law.
 *
 */
  
  
package com.dreamsocket.tracking.omniture
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.describeType;	

	import com.dreamsocket.tracking.omniture.OmnitureParams;	
	
	import com.omniture.ActionSource;


	public class OmnitureService
	{
		public static var display:DisplayObjectContainer;
		
		protected var m_config:OmnitureParams;
		protected var m_display:DisplayObjectContainer;
		protected var m_enabled:Boolean;
		protected var m_lastTrackParams:OmnitureParams;
		protected var m_tracker:ActionSource;

		
		public function OmnitureService(p_display:DisplayObjectContainer = null)
		{
			this.m_display = p_display;
			this.m_enabled = true;
		}
		
		
		public function get config():OmnitureParams
		{
			return this.m_config;
		}
		
		
		public function set config(p_config:OmnitureParams):void
		{
			if(p_config != this.m_config)
			{
				this.m_config = p_config;
				this.reset();
				this.mergeParams(p_config, this.m_tracker);
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
			if(this.m_tracker != null && this.m_display != null && this.m_display.contains(this.m_tracker))
			{
				this.m_display.removeChild(this.m_tracker);	
			}
			this.m_tracker = null;
			this.m_config = null;
			this.m_display = null;
			this.m_lastTrackParams = null;
			OmnitureService.display = null;
		}

		
		public function track(p_params:OmnitureParams):void
		{
			if(!this.m_enabled) return;
			
			this.resetTrackParams();
			this.m_lastTrackParams = p_params;
			this.mergeParams(p_params, this.m_tracker);
			
			try
			{
				this.m_tracker.track();
			}
			catch(error:Error)
			{
				trace(error);
			}
		}

		
		public function trackLink(p_params:OmnitureParams, p_URL:String, p_type:String, p_name:String):void
		{
			if(!this.m_enabled) return;
			
			this.resetTrackParams();
			this.m_lastTrackParams = p_params;
			this.mergeParams(p_params, this.m_tracker);
			
			try
			{
				this.m_tracker.trackLink(p_URL, p_type, p_name);
			}
			catch(error:Error)
			{
				trace(error);
			}
		}


		protected function mergeParams(p_params:OmnitureParams, p_destination:Object):void
		{
			var desc:XML = describeType(p_params);
			var propNode:XML;
			var props:XMLList = desc..variable;
			var type:String;
			var name:String;
			var val:*;
			
			// instance props
			for each(propNode in props)
			{
				name = propNode.@name;
				type = propNode.@type;
				val = p_params[name]; 
				if(val is String && val != null)
				{
					p_destination[name] = val;
				}
				else if(val is Number && !isNaN(val))
				{
					p_destination[name] = val;
				}
				else if(val is Boolean && val)
				{
					p_destination[name] = val;
				}	
			}	
			
			// dynamic props
			for(name in p_params)
			{	
				val = p_params[name]; 
				if(val is String && val != null)
				{
					p_destination[name] = val;
				}
				else if(val is Number && !isNaN(val))
				{
					p_destination[name] = val;
				}
				else if(val is Boolean && val)
				{
					p_destination[name] = val;
				}				
			}
		}

		
		protected function reset():void
		{
			if(this.m_config == null) return;
			
			this.m_display = this.m_display == null ? OmnitureService.display : this.m_display;
			
			if(this.m_tracker != null && this.m_display != null && this.m_display.contains(this.m_tracker))
			{
				this.m_display.removeChild(this.m_tracker);	
			}
			this.m_tracker = new ActionSource();
			if(this.m_tracker != null && this.m_display != null)
			{
				this.m_display.addChild(this.m_tracker);			
			}
		}

		
		protected function resetTrackParams():void
		{
			if(this.m_lastTrackParams == null) return;
			
			var params:OmnitureParams = this.m_config;
			var desc:XML = describeType(this.m_lastTrackParams);
			var propNode:XML;
			var props:XMLList = desc..variable;
			var type:String;
			var name:String;
			var val:*;
			
			// instance props
			for each(propNode in props)
			{
				name = propNode.@name;
				type = propNode.@type;
				
				val = this.m_lastTrackParams[name]; 
				if(val is String && val != null)
				{
					this.m_tracker[name] = params[name];
				}
				else if(val is Number && !isNaN(val))
				{
					this.m_tracker[name] = params[name];
				}
				else if(val is Boolean && val)
				{
					this.m_tracker[name] = params[name];
				}	
			}	
			
			// dynamic props
			for(name in this.m_lastTrackParams)
			{	
				val = this.m_lastTrackParams[name]; 
				if(val is String && val != null)
				{
					this.m_tracker[name] = params[name];
				}
				else if(val is Number && !isNaN(val))
				{
					this.m_tracker[name] = params[name];
				}
				else if(val is Boolean && val)
				{
					this.m_tracker[name] = params[name];
				}				
			}		
		}
	}
}
