package com.palDeveloppers.ane.events
{
	import flash.events.Event;
	
	public final class MediaPlayerBufferUpdateEvent extends Event
	{
		
		public static const BUFFER_UPDATE:String = "bufferUpdate";
		
		private var _percent:int;
		
		public function MediaPlayerBufferUpdateEvent(percent:int)
		{
			super(BUFFER_UPDATE);
			
			_percent = percent;
		}
		
		public function get percent():int {
			return _percent;
		}
		
		public function set percent(value:int):void {
			_percent = value;
		}
	}
}