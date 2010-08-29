package commands.note {
	import actors.DatabaseService;
	import actors.NotesModel;
	import actors.SharedObjectService;

	import events.NoteEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	// is only passed in a id to be removed in so&model

	public class RemoveNoteCommand extends Command {

		[Inject]
		public var noteevent:NoteEvent;

		[Inject]
		public var sharedobjectservice:SharedObjectService;

		[Inject]
		public var databaseservice:DatabaseService;

		[Inject]
		public var notesmodel:NotesModel;

		[Inject]
		public var logger:Logger;

		
		override public function execute():void {
			logger.log("removeNoteCommand: " + noteevent.data);
			
			if(sharedobjectservice.loggedIn) {
				databaseservice.removeNote(noteevent.data);
			} else {
				sharedobjectservice.removeNote(noteevent.data);
			}
			
			notesmodel.removeNote(noteevent.data);	
		}
	}
}
