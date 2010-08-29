package events {
	import flash.display.Stage;
	import flash.events.Event;

	/**
	 * @author am @ complexresponse.com
	 */
	public class ResizeEvent extends Event 
	{
		public static const RESIZE : String = "RESIZE";
		public var application_stage : Stage;
		
		public var top:int = 0;		public var bottom:int;		public var left:int = 0;		public var right:int;		public var horizontalCenter:int;		public var verticalCenter:int;

		public function ResizeEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function update() : void
		{
			bottom = Math.round(application_stage.stageHeight) as int;			right = Math.round(application_stage.stageWidth) as int;			horizontalCenter = Math.round(right / 2) as int;
			verticalCenter = Math.round(bottom / 2) as int;			
		}
	}
}
