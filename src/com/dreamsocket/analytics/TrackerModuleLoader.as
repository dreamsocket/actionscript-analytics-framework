﻿/*** Dreamsocket, Inc.* http://dreamsocket.com* Copyright  2010 Dreamsocket, Inc.* * Permission is hereby granted, free of charge, to any person* obtaining a copy of this software and associated documentation* files (the "Software"), to deal in the Software without* restriction, including without limitation the rights to use,* copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the* Software is furnished to do so, subject to the following* conditions:* * The above copyright notice and this permission notice shall be* included in all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR* OTHER DEALINGS IN THE SOFTWARE.**/ package com.dreamsocket.analytics{	import com.dreamsocket.analytics.ITracker;	import com.dreamsocket.analytics.TrackerModuleParams;	import com.dreamsocket.analytics.ITrackerModule;	import com.dreamsocket.analytics.TrackerModuleLoaderParams;	import com.dreamsocket.analytics.TrackerModuleLoaderEvent;	import flash.display.Loader;	import flash.display.Sprite;	import flash.events.ErrorEvent;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.events.SecurityErrorEvent;	import flash.net.URLRequest;	import flash.net.URLLoader;		public class TrackerModuleLoader extends Sprite	{		private var m_params:TrackerModuleLoaderParams;		private var m_config:XML;		private var m_module:ITrackerModule;		private var m_configLoader:URLLoader;		private var m_moduleLoader:Loader;		public function TrackerModuleLoader()		{		}				public function destroy():void		{			if(this.m_configLoader)			{				this.m_configLoader.removeEventListener(Event.COMPLETE, this.onConfigLoaded);				this.m_configLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);				this.m_configLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);				try				{					this.m_configLoader.close();				}				catch(error:Error){}								this.m_configLoader = null;			}			if(this.m_moduleLoader)			{				this.m_moduleLoader.contentLoaderInfo.removeEventListener(Event.INIT, this.onModuleLoaded);				this.m_moduleLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);				this.m_moduleLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);				try				{					this.m_moduleLoader.close();				}				catch(error:Error){}				try				{					this.m_moduleLoader.unload();				}								catch(error:Error){}								this.m_moduleLoader = null;			}							this.m_params = null;				this.m_config = null;			this.m_module = null;		}				public function load(p_resource:TrackerModuleLoaderParams):void		{			this.destroy();			this.m_params = p_resource;			this.loadConfig();		}						private function createModule():void		{			var params:TrackerModuleParams = new TrackerModuleParams();			params.stage = this.m_params.stage;			params.config = this.m_config;						try			{				var tracker:ITracker = this.m_module.getTracker(params);				var loadParams:TrackerModuleLoaderParams = this.m_params;								this.destroy();					this.dispatchEvent(new TrackerModuleLoaderEvent(TrackerModuleLoaderEvent.MODULE_LOADED, loadParams, tracker));							}			catch(error:Error)			{					trace("moduleLoaded:" + error)				this.dispatchError(error.message);			}			}				public function loadConfig():void		{			if(this.m_params.config is XML)			{	// this is XML load module				this.m_config = this.m_params.config;				this.loadModule();				return;			}						this.m_configLoader = new URLLoader();			this.m_configLoader.addEventListener(Event.COMPLETE, this.onConfigLoaded);			this.m_configLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);			this.m_configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);									try			{				this.m_configLoader.load(new URLRequest(this.m_params.config));				}			catch(error:Error)			{					this.dispatchError(error.message);			}		}						private function loadModule():void		{			if(this.m_params.resource is ITrackerModule)			{				this.m_module = this.m_params.resource;				this.createModule();				return;			}						// load the module				this.m_moduleLoader = new Loader();			this.m_moduleLoader.contentLoaderInfo.addEventListener(Event.INIT, this.onModuleLoaded);			this.m_moduleLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onErrorOccurred);			this.m_moduleLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onErrorOccurred);			try			{				this.m_moduleLoader.load(new URLRequest(this.m_params.resource));				}			catch(error:Error)			{					this.dispatchError(error.message);			}							}				private function dispatchError(p_message:String):void		{			trace(p_message)			var params:TrackerModuleLoaderParams = this.m_params;						this.destroy();			this.dispatchEvent(new TrackerModuleLoaderEvent(TrackerModuleLoaderEvent.MODULE_FAILED, params));		}				private function onErrorOccurred(p_event:ErrorEvent):void		{			this.dispatchError(p_event.text);		}						private function onConfigLoaded(p_event:Event):void		{			try 			{				this.m_config = new XML(this.m_configLoader.data);				this.loadModule();			}			catch(error:Error)			{				this.dispatchError(error.message);			}		}						private function onModuleLoaded(p_event:Event):void		{			this.m_module = ITrackerModule(this.m_moduleLoader.content);			this.createModule();		}			}}