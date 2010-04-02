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
