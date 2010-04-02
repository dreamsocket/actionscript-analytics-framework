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
 
 
package com.dreamsocket.analytics.js 
{
	import flash.utils.Dictionary;
	
	import com.dreamsocket.analytics.js.JSTrackerConfig;
	import com.dreamsocket.analytics.js.JSTrackHandler;
	import com.dreamsocket.analytics.js.JSTrackParamsXMLDecoder;

	public class JSTrackerConfigXMLDecoder 
	{	
		protected var m_paramsDecoder:JSTrackParamsXMLDecoder;
		
		public function JSTrackerConfigXMLDecoder()
		{
			this.m_paramsDecoder = new JSTrackParamsXMLDecoder();
		}

		
		public function decode(p_xml:XML):JSTrackerConfig
		{
			var config:JSTrackerConfig = new JSTrackerConfig();
			var handlerNodes:XMLList = p_xml.handlers.handler;
			var handlerNode:XML;
			var handlers:Dictionary = config.handlers;
			
			// handlers
			for each(handlerNode in handlerNodes)
			{
				this.addTrack(handlers, handlerNode);
			}
			// enabled
			config.enabled = p_xml.enabled.toString() != "false";
			
			return config;
		}	
		
		
		protected function addTrack(p_handlers:Dictionary, p_handlerNode:XML):void
		{		
			var ID:String = p_handlerNode.ID.toString();
			var handler:JSTrackHandler;
			
			if(ID.length > 0)
			{
				handler = new JSTrackHandler();
				handler.ID = ID;
				
				if(p_handlerNode.params[0] != null)
				{
					handler.params = (this.m_paramsDecoder.decode(p_handlerNode.params[0]));
					p_handlers[ID] = handler;
				}
			}
		}
	}
}
