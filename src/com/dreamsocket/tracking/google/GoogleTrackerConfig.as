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
 
 
 
package com.dreamsocket.tracking.google 
{
	import flash.utils.Dictionary;

	import com.google.analytics.core.TrackerMode;
	
	
	public class GoogleTrackerConfig 
	{
		public var account:String;
		public var enabled:Boolean;
		public var trackingMode:String; 
		public var visualDebug:Boolean;
		public var trackHandlers:Dictionary;
		
			
		public function GoogleTrackerConfig()
		{
			this.enabled = true;
			this.trackingMode = TrackerMode.AS3;
			this.trackHandlers = new Dictionary();
		}
	}
}
