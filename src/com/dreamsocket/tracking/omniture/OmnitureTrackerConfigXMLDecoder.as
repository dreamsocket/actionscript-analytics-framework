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
