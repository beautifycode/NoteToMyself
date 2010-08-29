package commands.note {
	import actors.DatabaseService;
	import actors.NotesModel;
	import actors.SharedObjectService;

	import components.Note;

	import events.NoteEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	public class BuildNoteCommand extends Command {
		[Inject]
		public var noteevent:NoteEvent;
		
		[Inject]
		public var notesmodel:NotesModel;
		
		[Inject]
		public var sharedobjectservice:SharedObjectService;

		[Inject]
		public var databaseservice:DatabaseService;
		
		[Inject]
		public var logger:Logger;	
		
		// main class for creating the note with passed data

		override public function execute():void {
			logger.log("buildNoteCommand: " + noteevent.data.noteID);
		
			var note:Note = new Note();
			note.id = noteevent.data.noteID;
			note.x = noteevent.data.noteX;
			note.y = noteevent.data.noteY;
			note.creationTime = noteevent.data.creationTime;
			note.creationDate = noteevent.data.creationDate;
			note.content = noteevent.data.noteBody;
			note.status = noteevent.data.noteStatus;
			
			switch(note.status) {
				case 0:
				notesmodel.addTrashNote(note);
				break;
				
				case 1:
				notesmodel.addNote(note);
				break;
			}
		}
	}
}
