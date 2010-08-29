package events {
	import flash.events.Event;

	/**
	 * @author Marvin
	 */
	public class NoteEvent extends Event {
		public var cType:String;
		public var data:*;
		
		public static const CREATE_NOTE:String = "CREATE_NOTE";
		public static const NOTEDATA_PARSED:String = "NOTEDATA_PARSED";
		
		public static const NOTEBUILD_COMPLETE:String = "NOTEBUILD_COMPLETE";
			
		public static const EDIT_NOTE:String = "EDIT_NOTE";
		
		public static const DELETE_NOTE:String = "DELETE_NOTE";
		public static const NOTE_DELETED:String = "NOTE_DELETED";

		public var user:*;
		public static const TRASHNOTEBUILD_COMPLETE:String = "TRASHNOTEBUILD_COMPLETE";
		public static const DESTROY_NOTE:String = "DESTROY_NOTE";
		public static const NOTE_DESTROYED:String = "NOTE_DESTROYED";

		public function NoteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			cType = type;
			super(cType, bubbles, cancelable);
		}

		override public function clone():Event {
			var clonedEvent:NoteEvent = new NoteEvent(this.cType, this.bubbles, this.cancelable);
			clonedEvent.data = this.data;
			
			return clonedEvent;
		}
	}
}
