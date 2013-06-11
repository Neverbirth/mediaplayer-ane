package com.palDeveloppers.ane.events
{
	import flash.events.Event;
	
	public final class MediaPlayerEvent extends Event
	{
		
		public static const SEEK_COMPLETED:String = "seekCompleted";
		public static const PREPARED:String = "prepared";
		public static const COMPLETED:String = "completed";
		
		public function MediaPlayerEvent(type:String)
		{
			super(type);
		}
	}
}