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
 
  
package com.dreamsocket.tracking.omniture
{

	public dynamic class OmnitureParams
	{
		// debug vars
		public var debugTracking:Boolean;
		public var trackLocal:Boolean;
				
		// required
		public var account:String;
		public var dc:String;
		public var pageName:String;
		public var pageURL:String;
		public var visitorNameSpace:String;
		
		// optional
		public var autoTrack:Boolean;
		public var charSet:String;
		public var cookieDomainPeriods:Number;
		public var cookieLifetime:String;	
		public var currencyCode:String;	
		public var delayTracking:Number;
		public var events:String;
		public var linkLeaveQueryString:Boolean;
		public var movieID:String;
		public var pageType:String;
		public var referrer:String;	
		public var trackClickMap:Boolean;
		public var trackingServer:String;
		public var trackingServerBase:String;
		public var trackingServerSecure:String;
		public var vmk:String;

		public function OmnitureParams()
		{			
		}
	}
}
