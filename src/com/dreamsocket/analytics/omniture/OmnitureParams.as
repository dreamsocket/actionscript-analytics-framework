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
	import com.dreamsocket.analytics.omniture.OmnitureMediaParams;
	
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
		
		// optional evars
		public var eVar1:String;
		public var eVar2:String;
		public var eVar3:String;
		public var eVar4:String;
		public var eVar5:String;
		public var eVar6:String;
		public var eVar7:String;
		public var eVar8:String;
		public var eVar9:String;
		public var eVar10:String;
		public var eVar11:String;
		public var eVar12:String;
		public var eVar13:String;
		public var eVar14:String;
		public var eVar15:String;
		public var eVar16:String;
		public var eVar17:String;
		public var eVar18:String;
		public var eVar19:String;
		public var eVar20:String;
		public var eVar21:String;
		public var eVar22:String;
		public var eVar23:String;
		public var eVar24:String;
		public var eVar25:String;
		public var eVar26:String;
		public var eVar27:String;
		public var eVar28:String;
		public var eVar29:String;
		public var eVar30:String;
		public var eVar31:String;
		public var eVar32:String;
		public var eVar33:String;
		public var eVar34:String;
		public var eVar35:String;
		public var eVar36:String;
		public var eVar37:String;
		public var eVar38:String;
		public var eVar39:String;
		public var eVar40:String;
		public var eVar41:String;
		public var eVar42:String;
		public var eVar43:String;
		public var eVar44:String;
		public var eVar45:String;
		public var eVar46:String;
		public var eVar47:String;
		public var eVar48:String;
		public var eVar49:String;
		public var eVar50:String;
		
		// optional props
		public var prop1:String;
		public var prop2:String;
		public var prop3:String;
		public var prop4:String;
		public var prop5:String;
		public var prop6:String;
		public var prop7:String;
		public var prop8:String;
		public var prop9:String;
		public var prop10:String;
		public var prop11:String;
		public var prop12:String;
		public var prop13:String;
		public var prop14:String;
		public var prop15:String;
		public var prop16:String;
		public var prop17:String;
		public var prop18:String;
		public var prop19:String;
		public var prop20:String;
		public var prop21:String;
		public var prop22:String;
		public var prop23:String;
		public var prop24:String;
		public var prop25:String;
		public var prop26:String;
		public var prop27:String;
		public var prop28:String;
		public var prop29:String;
		public var prop30:String;
		public var prop31:String;
		public var prop32:String;
		public var prop33:String;
		public var prop34:String;
		public var prop35:String;
		public var prop36:String;
		public var prop37:String;
		public var prop38:String;
		public var prop39:String;
		public var prop40:String;
		public var prop41:String;
		public var prop42:String;
		public var prop43:String;
		public var prop44:String;
		public var prop45:String;
		public var prop46:String;
		public var prop47:String;
		public var prop48:String;
		public var prop49:String;
		public var prop50:String;
		
		
		public var Media:OmnitureMediaParams;

		public function OmnitureParams()
		{		
			this.Media = new OmnitureMediaParams();	
		}
	}
}
