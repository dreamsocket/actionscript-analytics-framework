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
 
 
 
package com.dreamsocket.tracking.js 
{
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;

	import com.dreamsocket.utils.PropertyStringUtil;	
	import com.dreamsocket.tracking.ITrack;
	import com.dreamsocket.tracking.ITracker;
	import com.dreamsocket.tracking.js.JSTrackerConfig;
	import com.dreamsocket.tracking.js.JSTrackHandler;
	
	
	public class JSTracker implements ITracker
	{
		public static const ID:String = "JSTracker";
		
				
		protected var m_config:JSTrackerConfig;
		protected var m_enabled:Boolean;
		protected var m_trackHandlers:Dictionary;
		
		
		public function JSTracker()
		{
			super();
			
			this.m_config = new JSTrackerConfig();
			this.m_enabled = true;
			this.m_trackHandlers = new Dictionary();
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
		
		
		public function addTrackHandler(p_ID:String, p_trackHandler:JSTrackHandler):void
		{
			this.m_trackHandlers[p_ID] = p_trackHandler;
		}
		
		
		public function getTrackHandler(p_ID:String):JSTrackHandler
		{
			return this.m_trackHandlers[p_ID] as JSTrackHandler;	
		}
		
		
		public function removeTrackHandler(p_ID:String):void
		{
			delete(this.m_trackHandlers[p_ID]);	
		}	
		
						
		public function track(p_track:ITrack):void
		{
			if(!this.m_enabled) return;
			
			var handler:JSTrackHandler = this.m_trackHandlers[p_track.type];
			
			if(handler != null)
			{ // has the track type
				var methodCalls:Array = handler.methodCalls;
				var i:int = 0;
				var len:uint = methodCalls.length;
				
				while(i < len)
				{ 
					this.performJSCall(JSMethodCall(methodCalls[i]), p_track.data);
					i++;
				}
			}
		}
		
		protected function performJSCall(p_methodCall:JSMethodCall, p_data:* = null):void
		{
			;
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