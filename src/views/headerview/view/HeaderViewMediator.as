package views.headerview.view {
	import actors.NotesModel;

	import events.NoteEvent;
	import events.ResizeEvent;
	import events.UserEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Blase
	 */
	public class HeaderViewMediator extends Mediator {

		[Inject]
		public var headerview:HeaderView;

		[Inject]
		public var notesmodel:NotesModel;		

		override public function onRegister():void {
			eventMap.mapListener(eventDispatcher, ResizeEvent.RESIZE, onResize);
			
			eventMap.mapListener(eventDispatcher, UserEvent.LOGIN_SUCCESS, onLoginSuccess);
			eventMap.mapListener(eventDispatcher, UserEvent.LOGOUT_SUCCESS, onLogoutSuccess);
			
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTEBUILD_COMPLETE, onCreateNote);
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTE_DELETED, onDeleteNote);
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTE_DESTROYED, onDestroyNote);
		
			
			eventMap.mapListener(headerview, UserEvent.LOGIN_REQUEST, dispatch);
			eventMap.mapListener(headerview, UserEvent.LOGOUT_REQUEST, dispatch);
		}

		private function onDestroyNote(event:NoteEvent):void {
			var noteCount:int;
			for(var str:String in notesmodel.notesTrashObj) {
				noteCount++;
			}
			
			if(noteCount == 0) {
				headerview.updateHintState("As there are no Notes in your Trashbin the view has automatically switched.");
			}
		}

		private function onDeleteNote(event:NoteEvent):void {
			headerview.updateHintState("You have deleted a note. You can access it in your trashbin with Alt+DoubleClick.");
		}

		private function onCreateNote(event:NoteEvent):void {
			var noteCount:int;
			for(var str:String in notesmodel.notesObj) {
				noteCount++;
			}
			
			if(noteCount == 1) {
				headerview.updateHintState("You created your first note. You may move it now by dragging the icon.");
			}
		}

		private function onLogoutSuccess(event:UserEvent):void {
			headerview.switchLoginState(false, event.user);
		}

		private function onLoginSuccess(event:UserEvent):void {
			headerview.switchLoginState(true, event.user);
		}

		private function onResize(event:ResizeEvent):void {
			headerview.onResize(event);
		}
	}
}
