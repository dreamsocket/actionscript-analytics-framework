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
				request = HTTPUtil.addQueryParam(p_URL, "cacheID", HTTPUtil.getUniqueCacheID(p_rateInSecsToCache));
			}
			
			return request; 
		}	
		
		
		public static function getUniqueCacheID(p_rateInSecsToCache:Number = 0):String
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
			
			return ID;		
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
