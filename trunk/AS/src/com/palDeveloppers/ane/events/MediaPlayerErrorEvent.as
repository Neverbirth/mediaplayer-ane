package com.palDeveloppers.ane.events
{
	import flash.events.ErrorEvent;
	
	public final class MediaPlayerErrorEvent extends ErrorEvent
	{
		
		public static const ERROR:String = "error";
		
		public static const MEDIA_ERROR_UNKNOWN:int = 1;
		public static const MEDIA_ERROR_SERVER_DIED:int = 100;
		
		public static const MEDIA_ERROR_IO:int = -1004;
		public static const MEDIA_ERROR_MALFORMED:int = -1007;
		public static const MEDIA_ERROR_UNSUPPORTED:int = -1010;
		public static const MEDIA_ERROR_TIMED_OUT:int = -110;

		public function MediaPlayerErrorEvent(text:String="", id:int=0)
		{
			super(ERROR, false, false, text, id);
		}
	}
}