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
	import flash.utils.describeType;

	import com.dreamsocket.analytics.omniture.OmnitureParams;
	import com.dreamsocket.analytics.omniture.OmnitureMediaParamsMapper;
	import com.dreamsocket.utils.PropertyStringUtil;
	
	public class OmnitureParamsMapper 
	{
		public function OmnitureParamsMapper()
		{
		}
		
		public function map(p_params:OmnitureParams, p_data:*):OmnitureParams
		{
			var mapped:OmnitureParams = new OmnitureParams();
			var desc:XML = describeType(p_params);
			var propNode:XML;
			var props:XMLList = desc..variable;
			var prop:String;
			var val:*;
					
			// instance props
			for each(propNode in props)
			{
				prop = propNode.@name;
				val = p_params[prop]; 
				if(val is String && val != null)
				{
					mapped[prop] = PropertyStringUtil.evalPropertyString(p_data, val);
				}
			}					
			// dynamic prop
			for(prop in p_params)
			{ 
				mapped[prop] = PropertyStringUtil.evalPropertyString(p_data, p_params[prop]);
			}	
			
			mapped.Media = new OmnitureMediaParamsMapper().map(p_params.Media, p_data);
			
			return mapped;				
		}	
	}
}
