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
	import com.dreamsocket.analytics.omniture.OmnitureParams;
	
	
	public class OmnitureParamsXMLDecoder 
	{
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
			if(p_paramNodes.analyticsServer.length())	
				params.analyticsServer = p_paramNodes.analyticsServer.toString();
			if(p_paramNodes.analyticsServerBase.length())	
				params.analyticsServerBase = p_paramNodes.analyticsServerBase.toString();
			if(p_paramNodes.analyticsServerSecure.length())	
				params.analyticsServerSecure = p_paramNodes.analyticsServerSecure.toString();
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
			
			// media params
			var mediaNode:XML = p_paramNodes.Media[0];
			if(mediaNode != null)
			{
				params.Media = new OmnitureMediaParamsXMLDecoder().decode(mediaNode);
			}
			return params;		
		}		
	}
}
