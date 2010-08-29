package events {
	import flash.events.Event;

	/**
	 * @author Blase
	 */
	public class UserEvent extends Event {
		public static const LOGIN_REQUEST:String = "LOGIN_REQUEST";
		public static const LOGIN_SUCCESS:String = "LOGIN_SUCCESS";
		
		public static const LOGOUT_SUCCESS:String = "LOGOUT_SUCCESS";
		public static const LOGOUT_REQUEST:String = "LOGOUT_REQUEST";
		
		public static const LOGGED_OUT:String = "LOGGED_OUT";
		public static const LOGGED_IN:String = "LOGGED_IN";

		public var data:*;
		public var user:*;
		public var cType:String;

		public function UserEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			cType = type;
			super(type, bubbles, cancelable);
		}

		
		override public function clone():Event {
			var clonedEvent:UserEvent = new UserEvent(this.cType, this.bubbles, this.cancelable);
			clonedEvent.data = data;
			
			return clonedEvent;
		}
	}
}
