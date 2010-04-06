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
