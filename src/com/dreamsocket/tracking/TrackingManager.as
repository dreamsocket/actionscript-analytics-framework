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
  
  
package com.dreamsocket.tracking 
{
	import flash.utils.Dictionary;

	public class TrackingManager 
	{
		protected static var k_enabled:Boolean = true;
		protected static var k_trackers:Dictionary = new Dictionary();

		
		public function TrackingManager()
		{
		}
		
		
		public static function get enabled():Boolean
		{
			return k_enabled;
		}	
		
				
		public static function set enabled(p_enabled:Boolean):void
		{
			k_enabled = p_enabled;
		}


		
		public static function track(p_track:ITrack):void
		{
			if(!k_enabled) return;
			
			var tracker:Object;
			
			// send track payload to all trackers
			for each(tracker in k_trackers)
			{
				ITracker(tracker).track(p_track);
			}
		}

		
		public static function addTracker(p_ID:String, p_tracker:ITracker):void
		{
			k_trackers[p_ID] = p_tracker;
		}
		
		
		public static function getTracker(p_ID:String):ITracker
		{
			return k_trackers[p_ID] as ITracker;	
		}
		
		
		public static function removeTracker(p_ID:String):void
		{
			delete(k_trackers[p_ID]);	
		}		
	}
}
