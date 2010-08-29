package components {
	import events.NoteEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Marvin
	 */
	public class NoteMediator extends Mediator {
		[Inject]
		public var note:Note;
		
		override public function onRegister():void {
			eventMap.mapListener(note, NoteEvent.EDIT_NOTE, dispatch);
			eventMap.mapListener(note, NoteEvent.DELETE_NOTE, dispatch);
			eventMap.mapListener(note, NoteEvent.DESTROY_NOTE, dispatch);
		}
	}
}
