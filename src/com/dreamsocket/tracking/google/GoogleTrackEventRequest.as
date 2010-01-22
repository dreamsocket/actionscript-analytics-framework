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
	public class GoogleTrackEventRequest 
	{
		/**
		 * specifies a string representing groups of events.
		 */
		public var category:String; 
		
		/**
		 * specifies a string that is paired with each category and is typically used to track activities
		 */		
		public var action:String;
		
		/**
		 * specifies an optional string that provides additional scoping to the category/action pairing
		 */		 
		public var label:String; 
		
		/**
		 * specifies an optional non negative integer for numerical data
		 */		
		public var value:String; 	
		
		
		public function GoogleTrackEventRequest()
		{	
		}
	}
}
