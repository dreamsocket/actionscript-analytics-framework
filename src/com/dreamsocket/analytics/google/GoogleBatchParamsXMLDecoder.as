

/**
 * Dreamsocket
 *  
 * Copyright 2007 Dreamsocket.
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
package com.dreamsocket.analytics.google 
{
	import flash.utils.Dictionary;
	
	import com.dreamsocket.analytics.google.GoogleBatchParams;
	import com.dreamsocket.analytics.google.GoogleTrackHandler;
	import com.dreamsocket.analytics.google.GoogleTrackEventParamsXMLDecoder;
	import com.dreamsocket.analytics.google.GoogleTrackPageViewParamsXMLDecoder;

	public class GoogleBatchParamsXMLDecoder 
	{
		protected var m_decoders:Dictionary;
		
		public function GoogleBatchParamsXMLDecoder()
		{
			this.m_decoders = new Dictionary();
			this.m_decoders[GoogleTrackType.TRACK_EVENT] = new GoogleTrackEventParamsXMLDecoder();
			this.m_decoders[GoogleTrackType.TRACK_PAGE_VIEW] = new GoogleTrackPageViewParamsXMLDecoder();	
		}	
		
		
		public function decode(p_XML:XML):GoogleBatchParams
		{
			var handlerNode:XML;
			var handlerNodes:XMLList = p_XML.handler;
			var params:GoogleBatchParams = new GoogleBatchParams();
			var handler:GoogleTrackHandler;
			var handlers:Array = params.handlers;
			var type:String;
			
			for each(handlerNode in handlerNodes)
			{
				type = handlerNode.type.toString();
				if(this.m_decoders[type])
				{
					handler = new GoogleTrackHandler();
					handler.type = type;
					handler.params = this.m_decoders[type].decode(handlerNode.params[0]);
					handlers.push(handler);
				}
			}
			
			return params;			
		}			
	}
}
