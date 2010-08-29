package views.freeview.event {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class FreeViewEvent extends Event {
		public static const FIRST_NOTE_CREATED:String = "FIRST_NOTE_CREATED";
		public var data:*;
		
		public static const SORT_NOTES:String = "SORT_NOTES";
		public static const START_DRAG:String = "START_DRAG";
		public static const STOP_DRAG:String = "STOP_DRAG";

		public function FreeViewEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
