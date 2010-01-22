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
