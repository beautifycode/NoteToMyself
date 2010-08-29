package commands.note {
	import actors.DatabaseService;
	import actors.SharedObjectService;

	import events.NoteEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	 
	// is passed in variable data to change. the service will
	// only update data which was sent
	public class EditNoteCommand extends Command {

		[Inject]
		public var noteevent:NoteEvent;

		[Inject]
		public var sharedobjectservice:SharedObjectService;

		[Inject]
		public var databaseservice:DatabaseService;

		[Inject]
		public var logger:Logger;

		
		override public function execute():void {
			logger.log("noteEditCommand: " + noteevent.data.noteID);
			
			if(sharedobjectservice.loggedIn) {
				databaseservice.editNote(noteevent);
			} else {
				sharedobjectservice.editNote(noteevent);
			}
		}
	}
}
