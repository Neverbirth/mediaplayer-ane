package com.palDeveloppers.ane
{
	import com.palDeveloppers.ane.events.MediaPlayerBufferUpdateEvent;
	import com.palDeveloppers.ane.events.MediaPlayerErrorEvent;
	import com.palDeveloppers.ane.events.MediaPlayerEvent;
	import com.palDeveloppers.ane.events.MediaPlayerInfoEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.net.dns.AAAARecord;
	import flash.system.Capabilities;

	public class MediaPlayer extends EventDispatcher
	{
		public static const STREAM_VOICE_CALL:int = 0;
		public static const STREAM_SYSTEM:int = 1;
		public static const STREAM_RING:int = 2;
		public static const STREAM_MUSIC:int = 3;
		public static const STREAM_ALARM:int = 4;
		public static const STREAM_NOTIFICATION:int = 5;
		public static const STREAM_DTMF:int = 8;
		
		private static var _canInstatiate:Boolean;
		
		private var extCtx:ExtensionContext = null;
		
		private var cachedBufferingEvent:MediaPlayerBufferUpdateEvent;
		
		{
			initialize();
		}
		
		public function MediaPlayer()
		{
			if (!_canInstatiate)
				throw new Error("ANE not supported on this platform");
			
			extCtx = ExtensionContext.createExtensionContext("com.palDeveloppers.ane.MediaPlayer", null);
			if (extCtx == null)
				throw new Error("Error - Extension Context is null.");
			
			extCtx.addEventListener(StatusEvent.STATUS, onStatus);
		}
		
		private static function initialize():void
		{
			if (Capabilities.os.toLowerCase().indexOf("linux") > -1)
			{
				_canInstatiate = true;
			}
		}
		
		public static function isSupported():Boolean
		{
			return _canInstatiate;
		}
		
		public function getCurrentPosition():int
		{
			return int(extCtx.call("getCurrentPosition"));
		}
			
		public function getDuration():int
		{
			return int(extCtx.call("getDuration"));
		}
		
		public function isLooping():Boolean {
			return Boolean(extCtx.call("isLooping"));
		}
			
		public function isPlaying():Boolean {
			return Boolean(extCtx.call("isPlaying"));
		}
		
		public function pause():void {
			extCtx.call("pause");
		}
		
		public function prepare():void {
			extCtx.call("prepare");
		}
		
		public function prepareAsync():void {
			extCtx.call("prepareAsync");
		}
		
		public function dispose():void {
			extCtx.dispose();
		}
		
		public function reset():void {
			extCtx.call("reset");
		}
		
		public function seekTo(msec:int):void {
			extCtx.call("seekTo", msec);
		}
		
		public function setAudioStreamType(streamtype:int):void {
			extCtx.call("setAudioStreamType", streamtype);
		}
		
		public function setDataSource(path:String):void {
			extCtx.call("setDataSource", path);
		}
		
		public function setLooping(looping:Boolean):void {
			extCtx.call("setLooping", looping);
		}
		
		public function setVolume(leftVolume:Number, rightVolume:Number):void {
			extCtx.call("setVolume", leftVolume, rightVolume);
		}
		
		public function start():void {
			extCtx.call("start");
		}
		
		public function stop():void {
			extCtx.call("stop");
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
			if (type == MediaPlayerBufferUpdateEvent.BUFFER_UPDATE && hasEventListener(MediaPlayerBufferUpdateEvent.BUFFER_UPDATE))
				extCtx.call("setBufferListener", true);
			else if (type == MediaPlayerInfoEvent.INFO && !hasEventListener(MediaPlayerInfoEvent.INFO))
				extCtx.call("setInfoListener", true);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			super.removeEventListener(type, listener, useCapture);
			
			if (type == MediaPlayerBufferUpdateEvent.BUFFER_UPDATE && !hasEventListener(MediaPlayerBufferUpdateEvent.BUFFER_UPDATE))
				extCtx.call("setBufferListener", false);
			else if (type == MediaPlayerInfoEvent.INFO && !hasEventListener(MediaPlayerInfoEvent.INFO))
				extCtx.call("setInfoListener", false);
		}
		
		private function onStatus(event:StatusEvent):void
		{
			var data:Array;
			
			switch (event.code)
			{
				case "onCompletion":
					dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.COMPLETED));
					break;
				
				case "onSeekComplete":
					dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.SEEK_COMPLETED));
					break;
				
				case "onPrepared":
					dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.PREPARED));
					break;
				
				case "onBufferingUpdate":
					if (cachedBufferingEvent != null)
						cachedBufferingEvent.percent = int(event.level);
					else
						cachedBufferingEvent = new MediaPlayerBufferUpdateEvent(int(event.level));
					
					dispatchEvent(cachedBufferingEvent);
					break;
				
				case "onError":
					data = event.level.split(";");
					dispatchEvent(new MediaPlayerErrorEvent(data[0], data[1]));
					break;
				
				case "onInfo":
					data = event.level.split(";");
					dispatchEvent(new MediaPlayerInfoEvent(data[0], data[1]));
					break;
			}
		}
	}
}
