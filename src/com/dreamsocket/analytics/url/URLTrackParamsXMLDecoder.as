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


package com.dreamsocket.analytics.url 
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;

	public class URLTrackParamsXMLDecoder 
	{
		public function decode(p_XML:XML):Array
		{
			var params:Array = [];
			var requestNode:XML;
			var requestNodes:XMLList = p_XML.request;
			var request:URLRequest;
			
			for each(requestNode in requestNodes)
			{
				request = new URLRequest(requestNode.URL.toString());
	
				if(requestNode.data[0] != null)
				{
					request.method = URLRequestMethod.POST;
					request.data = this.decodeVars(requestNode.data[0]);
				}
				params.push(request);
			}
			
			return params;			
		}
				
		
		protected function decodeVars(p_data:XML):Object
		{
			if(p_data.hasSimpleContent())
			{	
				return p_data.children().toString();
			}
			
			var vars:Object = {};
			var varNode:XML;
			var varNodes:XMLList = p_data.children();
			for each(varNode in varNodes)
			{
				vars[varNode.name()] = varNode.children();		
			}
			return vars;
		}
	}
}
