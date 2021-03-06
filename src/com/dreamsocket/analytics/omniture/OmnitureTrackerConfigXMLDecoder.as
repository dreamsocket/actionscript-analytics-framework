﻿/**
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
 
  
package com.dreamsocket.analytics.omniture
{
	import flash.utils.Dictionary;

	import com.dreamsocket.analytics.omniture.OmnitureParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureTrackerConfig;
	import com.dreamsocket.analytics.omniture.OmnitureTrackHandler;
	import com.dreamsocket.analytics.omniture.OmnitureTrackType;
	
	import com.dreamsocket.analytics.omniture.OmnitureBatchParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureTrackParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureTrackLinkParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaCloseParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaTrackParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaOpenParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaPlayParamsXMLDecoder;
	import com.dreamsocket.analytics.omniture.OmnitureMediaStopParamsXMLDecoder;

	public class OmnitureTrackerConfigXMLDecoder 
	{
		protected var m_decoders:Dictionary;
		
		public function OmnitureTrackerConfigXMLDecoder()
		{
			this.m_decoders = new Dictionary();
			this.m_decoders[OmnitureTrackType.BATCH] = new OmnitureBatchParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.TRACK] = new OmnitureTrackParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.TRACK_LINK] = new OmnitureTrackLinkParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_TRACK] = new OmnitureMediaTrackParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_CLOSE] = new OmnitureMediaCloseParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_OPEN] = new OmnitureMediaOpenParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_PLAY] = new OmnitureMediaPlayParamsXMLDecoder();
			this.m_decoders[OmnitureTrackType.MEDIA_STOP] = new OmnitureMediaStopParamsXMLDecoder();	
		}
		
		
		public function decode(p_xml:XML):OmnitureTrackerConfig
		{
			var config:OmnitureTrackerConfig = new OmnitureTrackerConfig();
			
			config.enabled = p_xml.enabled.toString() != "false";
			config.params = new OmnitureParamsXMLDecoder().decode(p_xml.params[0]);
			this.createHandlers(config.handlers, p_xml.handlers.handler);
		
			return config;
		}		
		
		
		protected function createHandlers(p_handlers:Dictionary, p_handlerNodes:XMLList):void
		{
			var handler:OmnitureTrackHandler;
			var handlerNode:XML;
			var ID:String;
			for each(handlerNode in p_handlerNodes)
			{
				ID = handlerNode.ID.toString();
				if(ID.length > 0)
				{
					handler = new OmnitureTrackHandler();
					handler.ID = ID;
					handler.type = handlerNode.type.toString();
			
					if(this.m_decoders[handler.type])
					{
						handler.params = this.m_decoders[handler.type].decode(handlerNode.params[0]);				
					}	
					p_handlers[ID] = handler;
				}
			}	
		}
	}
}
