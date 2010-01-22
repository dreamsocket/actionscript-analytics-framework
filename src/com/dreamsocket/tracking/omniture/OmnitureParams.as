/**
 * Dreamsocket, Inc.
 *
 * Copyright  2009 Dreamsocket, Inc..
 * All Rights Reserved.
 *
 * This software (the "Software") is the property of Dreamsocket, Inc. and is protected by U.S. and
 * international intellectual property laws. No license is granted with respect to the
 * software and users may not, among other things, reproduce, prepare derivative works
 * of, modify, distribute, sublicense, reverse engineer, disassemble, remove, decompile,
 * or make any modifications of the Software without written permission from Dreamsocket, Inc..
 * Further, Dreamsocket, Inc. does not authorize any user to remove or alter any trademark, logo,
 * copyright or other proprietary notice, legend, symbol, or label in the Software.
 * This notice is not intended to, and shall not, limit any rights Dreamsocket, Inc. has under
 * applicable law.
 *
 */
  
  
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
