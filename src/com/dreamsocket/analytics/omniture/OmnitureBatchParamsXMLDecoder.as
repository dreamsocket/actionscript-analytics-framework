

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
package com.dreamsocket.analytics.omniture 
{
	import flash.utils.Dictionary;
	
	import com.dreamsocket.analytics.omniture.OmnitureBatchParams;
	import com.dreamsocket.analytics.omniture.OmnitureTrackHandler;	
	import com.dreamsocket.analytics.omniture.OmnitureTrackParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureTrackLinkParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaCloseParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaTrackParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaOpenParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaPlayParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaStopParamsXMLDecoder;
	
	
	public class OmnitureBatchParamsXMLDecoder 
	{
		protected var m_decoders:Dictionary;
		
		public function OmnitureBatchParamsXMLDecoder()
		{
			this.m_decoders = new Dictionary();
			this.m_decoders[OmnitureTrackType.TRACK] = new OmnitureTrackParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.TRACK_LINK] = new OmnitureTrackLinkParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_TRACK] = new OmnitureMediaTrackParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_CLOSE] = new OmnitureMediaCloseParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_OPEN] = new OmnitureMediaOpenParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_PLAY] = new OmnitureMediaPlayParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_STOP] = new OmnitureMediaStopParamsXMLDecoder();
		}	
		
		
		public function decode(p_XML:XML):OmnitureBatchParams
		{
			var handlerNode:XML;
			var handlerNodes:XMLList = p_XML.handler;
			var params:OmnitureBatchParams = new OmnitureBatchParams();
			var handler:OmnitureTrackHandler;
			var handlers:Array = params.handlers;
			var type:String;
			
			for each(handlerNode in handlerNodes)
			{
				type = handlerNode.type.toString();
				if(this.m_decoders[type])
				{
					handler = new OmnitureTrackHandler();
					handler.type = type;
					handler.params = this.m_decoders[type].decode(handlerNode.params[0]);
					handlers.push(handler);
				}
			}
			
			return params;			
		}			
	}
}
