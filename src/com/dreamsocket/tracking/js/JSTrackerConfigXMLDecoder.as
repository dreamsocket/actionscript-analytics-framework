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
	import flash.utils.Dictionary;
	
	import com.dreamsocket.tracking.js.JSTrackerConfig;
	import com.dreamsocket.tracking.js.JSTrackHandler;
	

	public class JSTrackerConfigXMLDecoder 
	{	
		public function JSTrackerConfigXMLDecoder()
		{
		}
		
		
		public function decode(p_xml:XML):JSTrackerConfig
		{
			var config:JSTrackerConfig = new JSTrackerConfig();
			var trackHandlerNodes:XMLList = p_xml.trackHandlers.trackHandler;
			var trackHandlerNode:XML;
			var trackHandlers:Dictionary = config.trackHandlers;
			
			// trackHandlers
			for each(trackHandlerNode in trackHandlerNodes)
			{
				this.addTrack(trackHandlers, trackHandlerNode);
			}
			// enabled
			config.enabled = p_xml.enabled.toString() != "false";
			
			return config;
		}	
		
		
		protected function addTrack(p_trackHandlers:Dictionary, p_trackHandlerNode:XML):void
		{		
			var ID:String = p_trackHandlerNode.ID.toString();
			var methodCallNode:XML;
			var handler:JSTrackHandler;
			
			if(ID.length > 0)
			{
				handler = new JSTrackHandler();
				for each(methodCallNode in p_trackHandlerNode.methodCalls.methodCall)
				{
					handler.methodCalls.push(this.createMethodCall(methodCallNode[0]));
				}
				p_trackHandlers[ID] = handler;
			}
		}
		
		protected function createMethodCall(p_methodNode:XML):JSMethodCall
		{
			var methodCall:JSMethodCall = new JSMethodCall(p_methodNode.ID.toString());
			var arguments:Array = p_methodNode.arguments.argument;
			var argumentNode
			for each()
			methodCall.arguments
		}
	}
}
