package events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class ViewEvent extends Event {
		public static const SWITCH_TO_TRASHVIEW:String = "SWITCH_TO_TRASHVIEW";
		public var data:String;

		public function ViewEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone():Event {
			var clonedEvent:ViewEvent = new ViewEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.data = data;
			
			return clonedEvent;
		}
	}
}
