package views.trashview.view {
	import events.NoteEvent;
	import events.ResizeEvent;
	import events.UserEvent;
	import events.ViewEvent;

	import views.freeview.model.FreeViewModel;
	import views.freeview.view.FreeView;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Marvin
	 */
	public class TrashViewMediator extends Mediator {

		[Inject]
		public var trashview:TrashView;

		//		[Inject]
		//		public var freeviewmodel:FreeViewModel;

		override public function onRegister():void {
			eventMap.mapListener(trashview, NoteEvent.CREATE_NOTE, dispatch);
			eventMap.mapListener(trashview, ViewEvent.SWITCH_TO_TRASHVIEW, dispatch);
			eventMap.mapListener(trashview, NoteEvent.EDIT_NOTE, onPositionEdit);
						
			eventMap.mapListener(eventDispatcher, UserEvent.LOGIN_SUCCESS, onLoginSuccess);
			eventMap.mapListener(eventDispatcher, UserEvent.LOGOUT_SUCCESS, onLogoutSuccess);
			
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTE_DELETED, onNoteRemoved);
			eventMap.mapListener(eventDispatcher, NoteEvent.TRASHNOTEBUILD_COMPLETE, onNoteStored);
			eventMap.mapListener(eventDispatcher, ResizeEvent.RESIZE, onResize);
			
			
			//sortNotes();
			onFirstHint();
		}

		private function onLoginSuccess(event:UserEvent):void {
			trashview.deleteNotes();
			
			event.cType = UserEvent.LOGGED_IN;
			dispatch(event);
		}

		private function onLogoutSuccess(event:UserEvent):void {
			trashview.deleteNotes();
			
			event.cType = UserEvent.LOGGED_OUT;
//			dispatch(event);
		}

		private function onResize(event:ResizeEvent):void {
			trashview.onResize(event);
		}

		private function onFirstHint():void {
		}

		private function onPositionEdit(event:NoteEvent):void {
			// new positions are passed and relayed
			//			freeviewmodel.editNotePosition(event.data);
			dispatch(event);
		}

		private function onNoteRemoved(event:NoteEvent):void {
			// only id passed
			trashview.removeNote(event.data);
		}

		private function onNoteStored(event:NoteEvent):void {
			// real displayobject created by builtcommand
			//			freeviewmodel.addNotePosition(event.data);
			trace("add trashed note");
			trashview.addNote(event.data);
		}
	}
}
