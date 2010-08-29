package {
	import actors.DatabaseService;
	import actors.NotesModel;
	import actors.SharedObjectService;

	import commands.InitializeCommand;
	import commands.note.BuildNoteCommand;
	import commands.note.CreateNoteCommand;
	import commands.note.DestroyNoteCommand;
	import commands.note.EditNoteCommand;
	import commands.note.RemoveNoteCommand;
	import commands.note.UpdateNoteParsingCommand;
	import commands.user.CheckLoginCommand;
	import commands.user.LogoutCommand;

	import components.Note;
	import components.NoteMediator;

	import control.MainMediator;

	import events.NoteEvent;
	import events.ResizeEvent;
	import events.UserEvent;

	import helpers.Logger;

	import views.BackgroundMediator;
	import views.BackgroundView;
	import views.NotesView;
	import views.NotesViewMediator;
	import views.freeview.model.FreeViewModel;
	import views.freeview.view.FreeView;
	import views.freeview.view.FreeViewMediator;
	import views.headerview.view.HeaderView;
	import views.headerview.view.HeaderViewMediator;
	import views.trashview.view.TrashView;
	import views.trashview.view.TrashViewMediator;

	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Marvin
	 */
	public class MainContext extends Context {
		private var notesview:NotesView;
		

		public function MainContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup():void {
			// services
			injector.mapSingleton(SharedObjectService);
			injector.mapSingleton(DatabaseService);
			
			// models
			injector.mapSingleton(NotesModel);
			injector.mapSingleton(FreeViewModel);

			// helper
			injector.mapSingleton(Logger);
			
			// mediatormapping
			mediatorMap.mapView(Main, MainMediator);
			mediatorMap.mapView(Note, NoteMediator);
			mediatorMap.mapView(NotesView, NotesViewMediator);
			mediatorMap.mapView(HeaderView, HeaderViewMediator);
			mediatorMap.mapView(FreeView, FreeViewMediator);
			mediatorMap.mapView(TrashView, TrashViewMediator);
			mediatorMap.mapView(BackgroundView, BackgroundMediator);
			
			// global startup						
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitializeCommand, ContextEvent, true);
			
			// request commands
			commandMap.mapEvent(UserEvent.LOGIN_REQUEST, CheckLoginCommand, UserEvent);
			commandMap.mapEvent(UserEvent.LOGOUT_REQUEST, LogoutCommand, UserEvent);
			
			// stage was cleared commands
			commandMap.mapEvent(UserEvent.LOGGED_IN, UpdateNoteParsingCommand, UserEvent);
			commandMap.mapEvent(UserEvent.LOGGED_OUT, UpdateNoteParsingCommand, UserEvent);
			
			// create note in db/so
			commandMap.mapEvent(NoteEvent.CREATE_NOTE, CreateNoteCommand, NoteEvent);

			// successfully added in db/so
			commandMap.mapEvent(NoteEvent.NOTEDATA_PARSED, BuildNoteCommand, NoteEvent);
			
			// edit note
			commandMap.mapEvent(NoteEvent.EDIT_NOTE, EditNoteCommand, NoteEvent);
			
			// delete note
			commandMap.mapEvent(NoteEvent.DELETE_NOTE, RemoveNoteCommand, NoteEvent);
			
			// destroy note
			commandMap.mapEvent(NoteEvent.DESTROY_NOTE, DestroyNoteCommand, NoteEvent);
			
			
			// build up mainview
			notesview = new NotesView();
			notesview.y = 145;
			
			contextView.addChild(new BackgroundView());
			contextView.addChild(notesview);
			contextView.addChild(new HeaderView());
			
			// global positioning call
			var resizeEvent:ResizeEvent = new ResizeEvent(ResizeEvent.RESIZE);
			resizeEvent.application_stage = contextView.stage;
			resizeEvent.update();
			dispatchEvent(resizeEvent);
			
			super.startup();
		}
	}
}
