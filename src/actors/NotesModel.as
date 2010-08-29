package actors {
	import components.Note;

	import events.NoteEvent;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Marvin
	 */
	 
	// frameworkmodel to hold note-displayobjects which are sent
	// in directly from build-command!

	
	
	public class NotesModel extends Actor {
		public var notesObj:Object;
		public var notesTrashObj:Object;

		
		public function NotesModel() {
			notesObj = new Object();
			notesTrashObj = new Object();
			super();
		}

		public function resetNotes():void {
			for(var str:String in notesObj) {
				delete notesObj[str];
			}	
		}

		public function addTrashNote(note:Note):void {
			notesTrashObj[note.id] = note;
			var noteStoredEvent:NoteEvent = new NoteEvent(NoteEvent.TRASHNOTEBUILD_COMPLETE, true, false);
			noteStoredEvent.data = note;
			
			dispatch(noteStoredEvent);	
		}

		public function addNote(note:Note):void {
			notesObj[note.id] = note;
			
			var noteStoredEvent:NoteEvent = new NoteEvent(NoteEvent.NOTEBUILD_COMPLETE, true, false);
			noteStoredEvent.data = note;
			
			dispatch(noteStoredEvent);	
		}

		public function removeNote(id:int):void {
			notesTrashObj[id] = notesObj[id];
			delete notesObj[id];
			
			var noteDeletedEvent:NoteEvent = new NoteEvent(NoteEvent.NOTE_DELETED, true, false);
			noteDeletedEvent.data = id;
			dispatch(noteDeletedEvent);
			
			var noteStoredEvent:NoteEvent = new NoteEvent(NoteEvent.TRASHNOTEBUILD_COMPLETE, true, false);
			noteStoredEvent.data = notesTrashObj[id];
			
			dispatch(noteStoredEvent);
		}

		public function destroyNote(id:int):void {
			delete notesTrashObj[id];
			
			var noteDestroyedEvent:NoteEvent = new NoteEvent(NoteEvent.NOTE_DESTROYED, true, false);
			noteDestroyedEvent.data = id;
			dispatch(noteDestroyedEvent);
		}
	}
}
