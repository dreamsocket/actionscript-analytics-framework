

/**
 * Dreamsocket
 *  
 * Copyright 2007 Dreamsocket.
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
package com.dreamsocket.analytics.url 
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

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
