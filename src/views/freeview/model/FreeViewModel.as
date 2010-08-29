package views.freeview.model {
	import components.Note;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Marvin
	 */
	 
	// is holding position data for cleanup, rasterize, e.g.
	public class FreeViewModel extends Actor {
		public var notePositionsObj:Object;
		public var sortedPositionsObj:Object;

		public function FreeViewModel() {
			notePositionsObj = new Object();
		}

		public function sortNotes():void {
			sortedPositionsObj = new Object();
			for(var str:String in notePositionsObj) {
				trace(str);
			}
		}

		public function editNotePosition(noteData:Object):void {
			notePositionsObj[noteData.noteID]['noteX'] = noteData.x;
			notePositionsObj[noteData.noteID]['noteY'] = noteData.y;
		}

		public function addNotePosition(note:Note):void {
			notePositionsObj[note.id] = new Object();
			notePositionsObj[note.id]['noteX'] = note.x;
			notePositionsObj[note.id]['noteY'] = note.y;
		}

		public function deleteNotes():void {
			for(var str:String in notePositionsObj) {
				delete notePositionsObj[str];
			}
		}
	}
}
