package views {
	import actors.NotesModel;

	import events.NoteEvent;
	import events.ResizeEvent;
	import events.UserEvent;
	import events.ViewEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Blase
	 */
	public class BackgroundMediator extends Mediator {

		[Inject]
		public var backgroundview:BackgroundView;

		[Inject]
		public var notesmodel:NotesModel;

		override public function onRegister():void {
			eventMap.mapListener(eventDispatcher, ResizeEvent.RESIZE, onResize);
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTEBUILD_COMPLETE, onCreateNote);
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTE_DELETED, onDeleteNote);
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTE_DESTROYED, onDeleteNote);
			eventMap.mapListener(eventDispatcher, ViewEvent.SWITCH_TO_TRASHVIEW, onTrashViewSwitch);
			eventMap.mapListener(eventDispatcher, UserEvent.LOGGED_OUT, onDeleteNote);
		}
		
		private function onTrashViewSwitch(event:ViewEvent):void {
			backgroundview.removeCloud();
		}

		private function onDeleteNote(event:*):void {
			var noteCount:int;
			for(var str:String in notesmodel.notesObj) {
				noteCount++;
			}

			for(var strTrash:String in notesmodel.notesTrashObj) {
//				noteCount++;
			}
			
			if(noteCount == 0) {
				backgroundview.addCloud();
			}
		}

		
		private function onCreateNote(event:NoteEvent):void {
			backgroundview.removeCloud();
		}

		private function onResize(event:ResizeEvent):void {
			backgroundview.onResize(event);
		}
	}
}
