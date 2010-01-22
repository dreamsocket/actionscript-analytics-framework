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
 
 
package com.dreamsocket.tracking.js 
{
	import flash.utils.Dictionary;
	
	import com.dreamsocket.tracking.js.JSTrackerConfig;
	import com.dreamsocket.tracking.js.JSTrackHandler;
	

	public class JSTrackerConfigXMLDecoder 
	{	
		public function JSTrackerConfigXMLDecoder()
		{
		}
		
		
		public function decode(p_xml:XML):JSTrackerConfig
		{
			var config:JSTrackerConfig = new JSTrackerConfig();
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
			var methodCallNode:XML;
			var handler:JSTrackHandler;
			
			if(ID.length > 0)
			{
				handler = new JSTrackHandler();
				for each(methodCallNode in p_trackHandlerNode.methodCalls.methodCall)
				{
					handler.methodCalls.push(this.createMethodCall(methodCallNode[0]));
				}
				p_trackHandlers[ID] = handler;
			}
		}
		
		protected function createMethodCall(p_methodNode:XML):JSMethodCall
		{
			var methodCall:JSMethodCall = new JSMethodCall(p_methodNode.ID.toString());
			var arguments:Array = p_methodNode.arguments.argument;
			var argumentNode
			for each()
			methodCall.arguments
		}
	}
}
