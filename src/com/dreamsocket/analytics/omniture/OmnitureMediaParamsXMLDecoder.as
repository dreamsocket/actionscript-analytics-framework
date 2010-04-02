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
	
	
	public class OmnitureMediaParamsXMLDecoder 
	{
		public function OmnitureMediaParamsXMLDecoder()
		{
		}
		
		
		public function decode(p_paramNodes:XML):OmnitureMediaParams
		{
			var params:OmnitureMediaParams = new OmnitureMediaParams();
			
			if(p_paramNodes == null) return params;

			if(p_paramNodes.autoTrack.toString().length)
				params.autoTrack = p_paramNodes.autoTrack.toString() == "true";
			if(p_paramNodes.trackWhilePlaying.toString().length)	
				params.trackWhilePlaying = p_paramNodes.trackWhilePlaying.toString() == "true";
			if(p_paramNodes.playerName.toString().length)
				params.playerName = p_paramNodes.playerName.toString();
			if(p_paramNodes.trackVars.toString().length)
				params.trackVars = p_paramNodes.trackVars.toString();
			if(p_paramNodes.trackEvents.toString().length)
				params.trackEvents = p_paramNodes.trackEvents.toString();
			if(p_paramNodes.trackMilestones.toString().length)
				params.trackMilestones = p_paramNodes.trackMilestones.toString();
			if(p_paramNodes.trackSeconds.toString().length)
				params.trackSeconds = Number(p_paramNodes.trackSeconds.toString());
			
			return params;		
		}		
	}
}
