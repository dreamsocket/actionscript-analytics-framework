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
	import flash.display.Stage;

	import com.omniture.ActionSource;

	public class OmnitureSingleton 
	{
		protected static var k_stage:Stage;
		protected static var k_instance:ActionSource;
	
		public function OmnitureSingleton()
		{
		}
		
		
		public static function set stage(p_display:Stage):void
		{
			OmnitureSingleton.create(p_display);
		}
		
	
		public static function create(p_display:Stage, p_actionSource:ActionSource = null):ActionSource
		{
			if(p_actionSource)
				k_instance = p_actionSource;
			
			var mod:ActionSource = OmnitureSingleton.instance;
			
			if(p_display != null && !mod.parent)
			{
				p_display.addChild(mod);
			}
			
			return k_instance;
		}	
		
		
		public static function get instance():ActionSource
		{
			if(k_instance == null)
			{
				k_instance = new ActionSource();
			}
			
			return k_instance;
		}
		
		
		public static function set instance(p_value:ActionSource):void
		{
			k_instance = p_value;
		}		
	}
}
