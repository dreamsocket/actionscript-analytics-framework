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
