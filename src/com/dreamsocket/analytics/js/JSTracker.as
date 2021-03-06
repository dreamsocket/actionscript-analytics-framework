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
 
 
package com.dreamsocket.analytics.js 
{
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;

	import com.dreamsocket.utils.PropertyStringUtil;	
	import com.dreamsocket.analytics.ITrack;
	import com.dreamsocket.analytics.ITracker;
	import com.dreamsocket.analytics.js.JSTrackerConfig;
	import com.dreamsocket.analytics.js.JSTrackHandler;
	
	
	public class JSTracker implements ITracker
	{
		public static const ID:String = "JSTracker";
		
				
		protected var m_config:JSTrackerConfig;
		protected var m_enabled:Boolean;
		protected var m_handlers:Dictionary;
		
		
		public function JSTracker()
		{
			super();
			
			this.m_config = new JSTrackerConfig();
			this.m_enabled = true;
			this.m_handlers = new Dictionary();
		}

		
		public function get config():JSTrackerConfig
		{
			return this.m_config;
		}
		
		
		public function set config(p_value:JSTrackerConfig):void
		{
			if(p_value != this.m_config)
			{
				this.m_config = p_value;
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
			return JSTracker.ID;
		}
				
		
		public function addTrackHandler(p_ID:String, p_handler:JSTrackHandler):void
		{
			this.m_handlers[p_ID] = p_handler;
		}
		
		
		public function getTrackHandler(p_ID:String):JSTrackHandler
		{
			return this.m_handlers[p_ID] as JSTrackHandler;	
		}
		
		
		public function removeTrackHandler(p_ID:String):void
		{
			delete(this.m_handlers[p_ID]);	
		}	
		
						
		public function track(p_track:ITrack):void
		{
			if(!this.m_enabled) return;
			
			var handler:JSTrackHandler = this.m_handlers[p_track.ID];
			
			if(handler != null)
			{ // has the track type
				this.performJSCall(handler.params, p_track.data);
			}
		}
		
		protected function performJSCall(p_methodCall:JSTrackParams, p_data:* = null):void
		{
			if(ExternalInterface.available)
			{
				try
				{
					var args:Array = p_methodCall.arguments.concat();
					var i:int = args.length;
					
					while(i--)
					{
						args[i] = PropertyStringUtil.evalPropertyString(p_data, args[i]);
					}
					
					args.unshift(p_methodCall.method);
					
					ExternalInterface.call.apply(ExternalInterface, args);
				}
				catch(error:Error)
				{	// do nothing
					trace("JSTracker.track - " + error);
				}
			}			
		}
	}
}