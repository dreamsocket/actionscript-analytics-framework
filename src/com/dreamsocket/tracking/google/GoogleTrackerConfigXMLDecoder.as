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
 
 
 
package com.dreamsocket.tracking.google 
{
	import flash.utils.Dictionary;

	import com.dreamsocket.tracking.google.GoogleTrackerConfig;
	import com.dreamsocket.tracking.google.GoogleTrackHandler;
	import com.dreamsocket.tracking.google.GoogleTrackEventRequest;
	import com.dreamsocket.tracking.google.GoogleTrackPageViewRequest;
	
	import com.google.analytics.core.TrackerMode;
	
	
	
	public class GoogleTrackerConfigXMLDecoder 
	{
		public function GoogleTrackerConfigXMLDecoder()
		{
			super();
		}
		
		
		public function decode(p_XML:XML):GoogleTrackerConfig
		{
			var config:GoogleTrackerConfig = new GoogleTrackerConfig();
			
			if(p_XML.account.toString().length)
				config.account = p_XML.account.toString();
					
			config.enabled = p_XML.enabled.toString() != "false";
			config.trackingMode = p_XML.trackingMode.toString() == TrackerMode.AS3 ? TrackerMode.AS3 : TrackerMode.BRIDGE;
			config.visualDebug = p_XML.visualDebug.toString() != "false";	
			
			this.setTrackHandlers(config.trackHandlers, p_XML.trackHandlers.trackHandler);
		
			return config;
		}		
		
		
		public function setTrackHandlers(p_handlers:Dictionary, p_handlerNodes:XMLList):void
		{
			var handler:GoogleTrackHandler;
			var handlerNode:XML;
			var ID:String;
			var eventRequest:GoogleTrackEventRequest;
			var pageViewRequest:GoogleTrackPageViewRequest;
			var trackNode:XML;
			
			for each(handlerNode in p_handlerNodes)
			{
				ID = handlerNode.ID.toString();
				if(ID.length > 0)
				{
					if(handlerNode.trackEvent.toString().length)
					{ // decode trackPageView
						handler = new GoogleTrackHandler();
						handler.ID = ID;
						handler.request = eventRequest = new GoogleTrackEventRequest();
						trackNode = handlerNode.trackEvent[0];
						
						if(trackNode.action.toString().length)
							eventRequest.action = trackNode.action.toString();
						if(trackNode.category.toString().length)
							eventRequest.category = trackNode.category.toString();
						if(trackNode.label.toString().length)
							eventRequest.label = trackNode.label.toString();
						if(trackNode.value.toString().length)
							eventRequest.value = trackNode.value.toString();	
							
						p_handlers[ID] = handler;																							
					}
					else if(handlerNode.trackPageView.toString().length)
					{	// decode track
						handler = new GoogleTrackHandler();
						handler.ID = ID;
						handler.request = pageViewRequest = new GoogleTrackPageViewRequest();
						trackNode = handlerNode.trackPageView[0];
							
						if(trackNode.URL.toString().length)					
							pageViewRequest.URL = trackNode.URL.toString();	
							
						p_handlers[ID] = handler;							
					}			
				}
			}	
		}
	}
}
