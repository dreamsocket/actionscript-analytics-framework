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
 
 
package com.dreamsocket.analytics.omniture 
{
	import com.dreamsocket.analytics.omniture.OmnitureMediaStopParams;
	import com.dreamsocket.analytics.omniture.OmnitureParamsXMLDecoder;
	
	public class OmnitureMediaStopParamsXMLDecoder 
	{
		
		public function decode(p_XML:XML):OmnitureMediaStopParams
		{
			var params:OmnitureMediaStopParams = new OmnitureMediaStopParams();
			
			if(p_XML.mediaName.toString().length)
				params.mediaName = p_XML.mediaName.toString();
			if(p_XML.mediaOffset.toString().length)
				params.mediaOffset = p_XML.mediaOffset.toString();
											
			params.params = new OmnitureParamsXMLDecoder().decode(p_XML.params[0]);
			
			return params;			
		}
	}
}
