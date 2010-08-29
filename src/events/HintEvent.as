package events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class HintEvent extends Event {
		public static const UPDATE_TEXT:String = "UPDATE_TEXT";
		public var data:String;

		public function HintEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone():Event {
			var clonedEvent:HintEvent = new HintEvent(this.type, this.bubbles, this.cancelable);
			clonedEvent.data = data;
			
			return clonedEvent;
		}
	}
}
