package commands {
	import views.freeview.event.FreeViewEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Blase
	 */
	public class ShowHintCommand extends Command {
		
		[Inject]
		public var freeviewevent:FreeViewEvent;

		override public function execute():void {	
		}
	}
}
