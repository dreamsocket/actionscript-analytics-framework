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
	import flash.display.Stage;
	import flash.utils.Dictionary;

	public class TrackerModuleManifestXMLDecoder 
	{
		protected var m_modules:Dictionary;
		protected var m_stage:Stage;
		
		public function TrackerModuleManifestXMLDecoder()
		{
			this.m_modules = new Dictionary();
		}


		public function set stage(p_value:Stage):void
		{
			this.m_stage = p_value;
		}

		
		public function addModuleDefinition(p_ID:String, p_module:ITrackerModule):void
		{
			this.m_modules[p_ID] = p_module;
		}

		
		public function decode(p_XML:XML):Array
		{
			var manifest:Array = [];
			var moduleNodeList:XMLList = p_XML.module;
			var moduleNode:XML;
			var moduleResource:TrackerModuleLoaderParams;
			
			for each(moduleNode in moduleNodeList)
			{
				moduleResource = new TrackerModuleLoaderParams();
				moduleResource.stage = this.m_stage;
				moduleResource.config = moduleNode.config.hasComplexContent() ? XML(moduleNode.config[0]) : moduleNode.config.toString();
				moduleResource.resource = this.m_modules[moduleNode.resource.toString()] ? this.m_modules[moduleNode.resource.toString()] : moduleNode.resource.toString();
				manifest.push(moduleResource);
			}
			
			return manifest;
		}
	}
}
