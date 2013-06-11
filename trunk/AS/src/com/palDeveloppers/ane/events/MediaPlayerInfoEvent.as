package com.palDeveloppers.ane.events
{
	import flash.events.Event;
	
	public final class MediaPlayerInfoEvent extends Event
	{
		public static const INFO:String = "info";
		
		public static const MEDIA_INFO_UNKNOWN:int = 1;
		public static const MEDIA_INFO_VIDEO_TRACK_LAGGING:int = 700; 
		public static const MEDIA_INFO_VIDEO_RENDERING_START:int = 3;
		public static const MEDIA_INFO_BUFFERING_START:int = 701;
		public static const MEDIA_INFO_BUFFERING_END:int = 702;
		public static const MEDIA_INFO_BAD_INTERLEAVING:int = 800;
		public static const MEDIA_INFO_NOT_SEEKABLE:int = 801;
		public static const MEDIA_INFO_METADATA_UPDATE:int = 802;
		
		private var _what:int;
		private var _extra:int;
		
		public function MediaPlayerInfoEvent(what:int, extra:int)
		{
			super(INFO, false, false);
			
			_what = what;
			_extra = extra;
		}
		
		public function get what():int {
			return _what;
		}
		
		public function get extra():int {
			return _extra;
		}
	}
}