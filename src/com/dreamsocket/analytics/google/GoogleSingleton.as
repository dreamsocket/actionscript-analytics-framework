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
 
 
package com.dreamsocket.analytics.google 
{
	import flash.display.Stage;

	import com.google.analytics.GATracker;
	
	public class GoogleSingleton 
	{
		protected static var k_stage:Stage;
		protected static var k_instance:GATracker;
	
		public function GoogleSingleton()
		{
		}
		
		
		public static function set stage(p_value:Stage):void
		{
			k_stage = p_value;
		}
		
	
		public static function create(p_account:String, p_trackingMode:String, p_visualDebug:Boolean, p_stage:Stage = null):GATracker
		{
			if(k_stage == null)
			{
				k_stage = p_stage;
			}
			if(k_instance == null)
			{
				k_instance = new GATracker(k_stage, p_account, p_trackingMode, p_visualDebug);
			}
			
			return k_instance;
		}	
		
		
		public static function get instance():GATracker
		{			
			return k_instance;
		}
	}
}
