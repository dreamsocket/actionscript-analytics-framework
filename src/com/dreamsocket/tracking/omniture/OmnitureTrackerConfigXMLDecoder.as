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
	import flash.utils.Dictionary;

	import com.dreamsocket.tracking.omniture.OmnitureParamsXMLDecoder;
	import com.dreamsocket.tracking.omniture.OmnitureTrackerConfig;
	import com.dreamsocket.tracking.omniture.OmnitureTrackHandler;
	
	
	public class OmnitureTrackerConfigXMLDecoder 
	{
		public function OmnitureTrackerConfigXMLDecoder()
		{
		}
		
		
		public function decode(p_xml:XML):OmnitureTrackerConfig
		{
			var config:OmnitureTrackerConfig = new OmnitureTrackerConfig();
			
			config.enabled = p_xml.enabled.toString() != "false";
			config.params = new OmnitureParamsXMLDecoder().decode(p_xml.params[0]);
			this.setTrackHandlers(config.trackHandlers, p_xml.trackHandlers.trackHandler);
		
			return config;
		}		
		
		
		public function setTrackHandlers(p_handlers:Dictionary, p_handlerNodes:XMLList):void
		{
			var handler:OmnitureTrackHandler;
			var handlerNode:XML;
			var ID:String;
			var trackLinkRequest:OmnitureTrackLinkRequest;
			var trackRequest:OmnitureTrackRequest;
			var paramsDecoder:OmnitureParamsXMLDecoder = new OmnitureParamsXMLDecoder();
			var trackNode:XML;
			for each(handlerNode in p_handlerNodes)
			{
				ID = handlerNode.ID.toString();
				if(ID.length > 0)
				{
					if(handlerNode.trackLink.toString().length)
					{ // decode trackLink
						handler = new OmnitureTrackHandler();
						handler.ID = ID;
						handler.request = trackLinkRequest = new OmnitureTrackLinkRequest();
						trackNode = handlerNode.trackLink[0];
						
						if(trackNode.name.toString().length)
							trackLinkRequest.name = trackNode.name.toString();
						if(trackNode.type.toString().length)
							trackLinkRequest.type = trackNode.type.toString();
						if(trackNode.URL.toString().length)
							trackLinkRequest.URL = trackNode.URL.toString();
							
						trackLinkRequest.params = paramsDecoder.decode(trackNode.params[0]);	
						
						p_handlers[ID] = handler;															
					}
					else if(handlerNode.track.toString().length)
					{	// decode track
						handler = new OmnitureTrackHandler();
						handler.ID = ID;
						handler.request = trackRequest = new OmnitureTrackRequest();
						trackNode = handlerNode.track[0];						
						trackRequest.params = paramsDecoder.decode(trackNode.params[0]);
						
						p_handlers[ID] = handler;							
					}			
				}
			}	
		}
	}
}
