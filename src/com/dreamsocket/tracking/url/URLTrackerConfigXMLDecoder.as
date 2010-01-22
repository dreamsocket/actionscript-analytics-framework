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
 
 
 
package com.dreamsocket.tracking.url 
{
	import flash.utils.Dictionary;
	
	import com.dreamsocket.tracking.url.URLTrackerConfig;
	import com.dreamsocket.tracking.url.URLTrackHandler;
	

	public class URLTrackerConfigXMLDecoder 
	{	
		public function URLTrackerConfigXMLDecoder()
		{
		}
		
		
		public function decode(p_xml:XML):URLTrackerConfig
		{
			var config:URLTrackerConfig = new URLTrackerConfig();
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
			var urlNode:XML;
			var handler:URLTrackHandler;
			
			if(ID.length > 0)
			{
				handler = new URLTrackHandler();
				for each(urlNode in p_trackHandlerNode.URLs.URL)
				{
					handler.URLs.push(urlNode.toString());
				}
				p_trackHandlers[ID] = handler;
			}
		}
	}
}
