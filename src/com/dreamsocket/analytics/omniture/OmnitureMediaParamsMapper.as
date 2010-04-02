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
	import com.dreamsocket.analytics.omniture.OmnitureMediaParams;
	import com.dreamsocket.utils.PropertyStringUtil;
	
	public class OmnitureMediaParamsMapper 
	{
		public function OmnitureMediaParamsMapper()
		{
		}
		
		public function map(p_params:OmnitureMediaParams, p_data:*):OmnitureMediaParams
		{
			var mapped:OmnitureMediaParams = new OmnitureMediaParams();
			
			if(p_params.playerName != null)		
				mapped.playerName = PropertyStringUtil.evalPropertyString(p_data, p_params.playerName);
			if(p_params.trackVars != null)	
				mapped.trackVars = PropertyStringUtil.evalPropertyString(p_data, p_params.trackVars);
			if(p_params.trackEvents != null)	
				mapped.trackEvents = PropertyStringUtil.evalPropertyString(p_data, p_params.trackEvents);
			
			return mapped;				
		}	
	}
}
