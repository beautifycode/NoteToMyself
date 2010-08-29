package commands.note {
	import actors.DatabaseService;
	import actors.NotesModel;
	import actors.SharedObjectService;

	import events.UserEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Blase
	 */
	public class UpdateNoteParsingCommand extends Command {
		[Inject]
		public var notesmodel:NotesModel;

		[Inject]
		public var userevent:UserEvent;

		[Inject]
		public var sharedobjectservice:SharedObjectService;

		[Inject]
		public var databaseservice:DatabaseService;

		[Inject]
		public var logger:Logger;

		override public function execute():void {
			
			switch(userevent.type) {
				case UserEvent.LOGGED_OUT:
					logger.log("updateNoteParsingType is now: SharedObject, by:" + userevent.type);
					notesmodel.resetNotes();
					sharedobjectservice.loggedIn = false;
					sharedobjectservice.requestData();
				break;
				
				case UserEvent.LOGGED_IN:
					logger.log("updateNoteParsingType is now: Database");
					notesmodel.resetNotes();
					sharedobjectservice.loggedIn = true;
					databaseservice.parseNoteData(userevent.data);					
				break;
			}
		}
	}
}
