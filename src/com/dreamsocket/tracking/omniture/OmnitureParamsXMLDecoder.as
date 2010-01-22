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
 
 
 
package com.dreamsocket.tracking.omniture 
{
	import com.dreamsocket.tracking.omniture.OmnitureParams;
	
	
	public class OmnitureParamsXMLDecoder 
	{
		protected var m_params:OmnitureParams;
		
		
		public function OmnitureParamsXMLDecoder()
		{
		}
		
		
		public function decode(p_paramNodes:XML):OmnitureParams
		{
			var params:OmnitureParams = new OmnitureParams();
			
			if(p_paramNodes == null) return params;
			// debug
			if(p_paramNodes.debugTracking.toString().length)
				params.debugTracking = p_paramNodes.debugTracking.toString() == "true";
			if(p_paramNodes.trackLocal.toString().length)	
				params.trackLocal = p_paramNodes.trackLocal.toString() == "true";
			
			// required
			if(p_paramNodes.account.toString().length)
				params.account = p_paramNodes.account.toString();
			if(p_paramNodes.dc.toString().length)
				params.dc = p_paramNodes.dc.toString();
			if(p_paramNodes.pageName.toString().length)
				params.pageName = p_paramNodes.pageName.toString();
			if(p_paramNodes.pageURL.toString().length)
				params.pageURL = p_paramNodes.pageURL.toString();
			if(p_paramNodes.visitorNameSpace.toString().length)
				params.visitorNameSpace = p_paramNodes.visitorNameSpace.toString();

			// optional
			if(p_paramNodes.autoTrack.length())
				params.autoTrack = p_paramNodes.autoTrack.toString() == "true";
			if(p_paramNodes.charSet.length())	
				params.charSet = p_paramNodes.charSet.toString();
			if(p_paramNodes.cookieDomainPeriods.length())	
				params.cookieDomainPeriods = int(p_paramNodes.cookieDomainPeriods.toString());
			if(p_paramNodes.cookieLifetime.length())	
				params.cookieLifetime = p_paramNodes.cookieLifetime.toString();
			if(p_paramNodes.currencyCode.length())	
				params.currencyCode = p_paramNodes.currencyCode.toString();
			if(p_paramNodes.delayTracking.length())	
				params.delayTracking = Number(p_paramNodes.delayTracking.toString());
			if(p_paramNodes.linkLeaveQueryString.length())	
				params.linkLeaveQueryString = p_paramNodes.linkLeaveQueryString.toString() == true;
			if(p_paramNodes.pageType.length())	
				params.pageType = p_paramNodes.pageType.toString();
			if(p_paramNodes.referrer.length())	
				params.referrer = p_paramNodes.referrer.toString();
			if(p_paramNodes.trackClickMap.length())	
				params.trackClickMap = p_paramNodes.trackClickMap.toString() == "true";
			if(p_paramNodes.trackingServer.length())	
				params.trackingServer = p_paramNodes.trackingServer.toString();
			if(p_paramNodes.trackingServerBase.length())	
				params.trackingServerBase = p_paramNodes.trackingServerBase.toString();
			if(p_paramNodes.trackingServerSecure.length())	
				params.trackingServerSecure = p_paramNodes.trackingServerSecure.toString();
			if(p_paramNodes.vmk.length())	
				params.vmk = p_paramNodes.vmk.toString();
		
			var paramNode:XML;
			for each(paramNode in p_paramNodes.*)
			{
				if(params[paramNode.name()] == undefined)
				{
					params[paramNode.name()] = paramNode.toString();
				}
			}	
			
			return params;		
		}		
	}
}
