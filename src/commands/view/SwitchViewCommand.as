package commands.view {
	import events.ViewEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	public class SwitchViewCommand extends Command {
		[Inject]
		public var viewevent:ViewEvent;
		
		override public function execute():void {
			switch(viewevent.type) {
				case ViewEvent.SWITCH_TO_TRASHVIEW:
				break;
			}
		}
	}
}
