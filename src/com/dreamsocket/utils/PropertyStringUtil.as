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
 
 
package com.dreamsocket.utils 
{
	public class PropertyStringUtil 
	{
		public function PropertyStringUtil()
		{
		}
		
		
		public static function evalPropertyString(p_data:*, p_value:String):String
		{
			if(p_data == null || p_value == null) return null;
			
			return p_value.replace(
				new RegExp("\\${.*?}", "gi"), 
				function():String 
				{
					return (PropertyStringUtil.evalSinglePropertyString(p_data, arguments[0].replace(new RegExp( "\\${|}", "gi"), "")));
				}
			);
		}
		
		
		protected static function evalSinglePropertyString(p_data:*, p_value:String = null):*
		{
			var val:String = p_value == null ? "" : p_value; 
			var currPart:* = p_data;
			var parts:Array;
			var key:String;
			
			parts = val.split(".");
			key = parts.shift();
			
			switch(key)
			{
				case "cache.UID":
					currPart = new Date().valueOf();
					break;
				case "data":
					try
					{
						var i:uint = 0;
						var len:uint = parts.length;
						if(len != 0)
						{
							for(; i < len; i++)
							{
								currPart = currPart[parts[i]];
							}
						}
					}
					catch(error:Error)
					{
						currPart = null;
					}	
					break;				
			}

			return (currPart);
		}				
	}
}
