package views {
	import actors.NotesModel;

	import events.NoteEvent;
	import events.ViewEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Marvin
	 */
	public class NotesViewMediator extends Mediator {

		[Inject]
		public var notesview:NotesView;
		
		[Inject]
		public var notesmodel:NotesModel;
		
		[Inject]
		public var logger:Logger;

		override public function onRegister():void {
			eventMap.mapListener(eventDispatcher, ViewEvent.SWITCH_TO_TRASHVIEW, switchToTrashView);
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTE_DESTROYED, onNoteRemove);
		}

		private function onNoteRemove(event:NoteEvent):void {
			var noteCount:int;
			
			for(var strTrash:String in notesmodel.notesTrashObj) {
				noteCount++;
			}
			
			if(noteCount == 0) {
				notesview.switchView("freeview");
			}
		}

		private function switchToTrashView(event:ViewEvent):void {
			var noteCount:int;
			
			for(var strTrash:String in notesmodel.notesTrashObj) {
				noteCount++;
			}
			
			if(noteCount != 0) {
				notesview.switchView(event.data);
			} else {
				logger.log("no trashed notes = no switch.")				
			}
		}
	}
}
