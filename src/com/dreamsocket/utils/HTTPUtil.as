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
 
 
package com.dreamsocket.utils 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.system.Security;
	import flash.utils.Dictionary;

	public class HTTPUtil
	{
		public static var allowLocalQueryStrings:Boolean = false;
		
		protected static var k_pings:Dictionary = new Dictionary();

		
		public function HTTPUtil()
		{
		}
		
		
		public static function pingURL(p_URL:String, p_clearCache:Boolean = true, p_rateInSecsToCache:Number = 0):void
		{	
			if(p_URL == null) return;
			
			var loader:URLLoader = new URLLoader();
			var URL:String = p_URL;
			
			if(p_clearCache && (HTTPUtil.allowLocalQueryStrings || Security.sandboxType == Security.REMOTE))
			{	
				URL = HTTPUtil.resolveUniqueURL(p_URL, p_rateInSecsToCache);
			}
						
			loader.load(new URLRequest(URL));			
			loader.addEventListener(Event.COMPLETE, HTTPUtil.onPingResult);
			loader.addEventListener(IOErrorEvent.IO_ERROR, HTTPUtil.onPingResult);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, HTTPUtil.onPingResult);

			HTTPUtil.k_pings[loader] = true;
		}
		
		
		public static function addQueryParam(p_URL:String, p_name:String, p_val:String, p_delimeter:String = null):String
		{
			if(HTTPUtil.allowLocalQueryStrings || Security.sandboxType == Security.REMOTE)
			{
				if(p_delimeter == null)
					p_URL += (p_URL.indexOf( "?" ) != -1 ) ? "&" + p_name + "=" : "?" + p_name + "=";
				else
					p_URL += p_delimeter + p_name + "=";
				p_URL += p_val != null ? escape(p_val) : "";
			}
			return p_URL;
		}
		
		
		public static function resolveUniqueURL(p_URL:String, p_rateInSecsToCache:Number = 0):String
		{
			var request:String = p_URL;

			if((HTTPUtil.allowLocalQueryStrings || Security.sandboxType == Security.REMOTE) && p_URL.indexOf( "&cacheID=" ) == -1 && p_URL.indexOf( "?cacheID=" ) == -1) 
			{
				var d:Date = new Date();
				var ID:String;
				var secsPassed:Number = (60 * d.getUTCMinutes()) + d.getUTCSeconds();

				if(p_rateInSecsToCache == 0)
				{
					ID = String(d.valueOf());
				}
				else
				{
					ID = d.getUTCFullYear() + "" + d.getUTCMonth() + "" +d.getUTCDate() + "" +d.getUTCHours() + "-" + Math.floor(secsPassed/p_rateInSecsToCache);
				}

				request = HTTPUtil.addQueryParam(p_URL, "cacheID", ID);
			}
			
			return request; 
		}	
		
				
		protected static function onPingResult(p_event:Event):void
		{	// NOTE: let errors be thrown or log them if you want to handle them
			URLLoader(p_event.target).removeEventListener(Event.COMPLETE, HTTPUtil.onPingResult);
			URLLoader(p_event.target).removeEventListener(IOErrorEvent.IO_ERROR, HTTPUtil.onPingResult);
			URLLoader(p_event.target).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, HTTPUtil.onPingResult);
			delete(HTTPUtil.k_pings[p_event.target]);
		}
	}		
}
