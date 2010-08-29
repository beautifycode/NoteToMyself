package commands.note {
	import actors.DatabaseService;
	import actors.SharedObjectService;

	import events.NoteEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	// main class for creating a new data-entry in db&shared object
	public class CreateNoteCommand extends Command {

		[Inject]
		public var noteevent:NoteEvent;

		[Inject]
		public var sharedobjectservice:SharedObjectService;

		[Inject]
		public var databaseservice:DatabaseService;

		[Inject]
		public var logger:Logger;	

		
		override public function execute():void {
			logger.log("createNoteCommand");
		
			if(sharedobjectservice.loggedIn) {
				databaseservice.createNote(noteevent);
			} else {
				sharedobjectservice.createNote(noteevent);
			}
		}
	}
}
