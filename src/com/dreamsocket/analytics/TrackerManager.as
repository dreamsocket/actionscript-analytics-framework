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
  
  
package com.dreamsocket.analytics 
{
	import flash.utils.Dictionary;

	public class TrackerManager 
	{
		protected static var k_enabled:Boolean = true;
		protected static var k_queued:Boolean = false;
		protected static var k_queuedTracks:Array = [];
		protected static var k_trackers:Dictionary = new Dictionary();
		protected static var k_trackerCount:uint;

		
		public function TrackerManager()
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


		public static function get queued():Boolean
		{
			return k_queued;
		}
		

		public static function set queued(p_value:Boolean):void
		{
			if(p_value != k_queued)
			{
				k_queued = p_value;
				
				if(!p_value)
				{	// if previously queued, track all items in the queue
					trackItemsInQueue();
				}
			}
		}

		
		public static function track(p_track:ITrack):void
		{
			if(!k_enabled) return;
			
			if(k_queued || k_trackerCount == 0)
			{
				k_queuedTracks.push(p_track);
				return;
			}
			var tracker:Object;
			// if any queued items exist assume that all trackers have been added and send out their payloads
			trackItemsInQueue();
			
			// send track payload to all trackers
			for each(tracker in k_trackers)
			{
				ITracker(tracker).track(p_track);
			}
		}

		
		public static function addTracker(p_ID:String, p_tracker:ITracker):void
		{
			if(!k_trackers[p_ID])
			{
				k_trackerCount++;
			}
			k_trackers[p_ID] = p_tracker;
		}
		
		
		public static function clearQueue():void
		{
			 k_queuedTracks.splice(0);		
		}
		
				
		public static function getTracker(p_ID:String):ITracker
		{
			return k_trackers[p_ID] as ITracker;	
		}
		
		
		public static function removeTracker(p_ID:String):void
		{
			if(!k_trackers[p_ID])
			{
				k_trackerCount--;
			}			
			delete(k_trackers[p_ID]);	
		}
		
		
		public static function trackItemsInQueue():void
		{
			var queuedTrack:ITrack; 
			while(queuedTrack = k_queuedTracks.shift())
				track(queuedTrack);				
		}			
	}
}
