package control {
	import events.ResizeEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;

	/**
	 * @author Blase
	 */
	public class MainMediator extends Mediator {
		[Inject]
		public var view:Main;

		override public function onRegister():void {
			eventMap.mapListener(view.stage, Event.RESIZE, onResize);
			onResize(null);
		}

		private function onResize(event:Event):void {
			var resizeEvent:ResizeEvent = new ResizeEvent(ResizeEvent.RESIZE);
			resizeEvent.application_stage = view.stage;
			resizeEvent.update();
			
			dispatch(resizeEvent);
		}
	}
}
