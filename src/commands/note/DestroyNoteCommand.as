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
	public class DestroyNoteCommand extends Command {

		[Inject]
		public var logger:Logger;

		[Inject]
		public var noteevent:NoteEvent;

		[Inject]
		public var sharedobjectservice:SharedObjectService;

		[Inject]
		public var databaseservice:DatabaseService;

		[Inject]
		public var notesmodel:NotesModel;

		override public function execute():void {
			logger.log("destroyNoteCommand: " + noteevent.data);
			
			if(sharedobjectservice.loggedIn) {
				databaseservice.destroyNote(noteevent.data);
			} else {
				sharedobjectservice.destroyNote(noteevent.data);
			}	
			notesmodel.destroyNote(noteevent.data);
		}
	}
}
