package views.freeview.view {
	import events.NoteEvent;
	import events.ResizeEvent;
	import events.UserEvent;
	import events.ViewEvent;

	import views.freeview.event.FreeViewEvent;
	import views.freeview.model.FreeViewModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Marvin
	 */
	public class FreeViewMediator extends Mediator {

		[Inject]
		public var freeview:FreeView;

		[Inject]
		public var freeviewmodel:FreeViewModel;

		override public function onRegister():void {
			eventMap.mapListener(freeview, NoteEvent.CREATE_NOTE, dispatch);
			eventMap.mapListener(freeview, ViewEvent.SWITCH_TO_TRASHVIEW, dispatch);
			eventMap.mapListener(freeview, NoteEvent.EDIT_NOTE, onPositionEdit);
			
			eventMap.mapListener(freeview, FreeViewEvent.SORT_NOTES, dispatch);
			
			eventMap.mapListener(eventDispatcher, UserEvent.LOGIN_SUCCESS, onLoginSuccess);
			eventMap.mapListener(eventDispatcher, UserEvent.LOGOUT_SUCCESS, onLogoutSuccess);
			
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTE_DELETED, onNoteRemoved);
			eventMap.mapListener(eventDispatcher, NoteEvent.NOTEBUILD_COMPLETE, onNoteStored);
			eventMap.mapListener(eventDispatcher, ResizeEvent.RESIZE, onResize);
			
			
			//sortNotes();
			onFirstHint();
		}

		private function onLoginSuccess(event:UserEvent):void {
			freeviewmodel.deleteNotes();
			freeview.deleteNotes();
			
			event.cType = UserEvent.LOGGED_IN;
			dispatch(event);
		}

		private function onLogoutSuccess(event:UserEvent):void {
			freeviewmodel.deleteNotes();
			freeview.deleteNotes();
			
			event.cType = UserEvent.LOGGED_OUT;
			dispatch(event);
		}

		private function onResize(event:ResizeEvent):void {
			freeview.onResize(event);
		}

		private function onFirstHint():void {
		}

		private function onPositionEdit(event:NoteEvent):void {
			// new positions are passed and relayed
			freeviewmodel.editNotePosition(event.data);
			dispatch(event);
		}

		private function onNoteRemoved(event:NoteEvent):void {
			// only id passed
			freeview.removeNote(event.data);
		}

		private function onNoteStored(event:NoteEvent):void {
			// real displayobject created by builtcommand
			freeviewmodel.addNotePosition(event.data);
			freeview.addNote(event.data);
		}
	}
}
