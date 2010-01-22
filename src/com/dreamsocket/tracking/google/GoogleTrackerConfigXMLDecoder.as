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
