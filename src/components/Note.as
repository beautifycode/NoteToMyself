package components {
	import flash.text.TextFieldType;
	import events.NoteEvent;

	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	

	
	
	

	
	
	

	
	
	
	

	
	

	
	

	/**
	 * @author Marvin
	 */
	 
	TweenPlugin.activate([AutoAlphaPlugin]);

	// carrying most of the note's skills
	public class Note extends NoteAsset {
		public var id:int;
		public var status:int;

		private var _content:String;
		private var _creationTime:String;
		private var _creationDate:String;

		public function Note() {
			startupAnimation();
			setupFunctionality();
		}

		private function startupAnimation():void {
			TweenLite.from(noteIcon, .3, {alpha:0});
			TweenLite.from(noteDate, .3, {delay:.2, alpha:0});
			TweenLite.from(noteTime, .3, {delay:.3, alpha:0});
			TweenLite.from(noteBack, .3, {delay:.5, alpha:0, y:"10"});
			TweenLite.to(noteBack.noteShadow, .3, {delay:.5, alpha:.5, y:"10"});
			TweenLite.from(noteTF, .3, {delay:.9, alpha:0});
		}

		private function setupFunctionality():void {
			noteIcon.buttonMode = true;
			
			noteTF.content.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			noteDelBtn.buttonMode = true;
			noteDelBtn.addEventListener(MouseEvent.CLICK, onDelBtnClick);
		}

		
		
		private function fadeoutAnimation():void {
			TweenLite.to(this, 1, {autoAlpha:0, onComplete:removeFunctionality});
		}

		private function removeFunctionality():void {
			if(this.status == 1) {
				this.status = 0;
				noteTF.content.type = TextFieldType.DYNAMIC;

				
				var deleteEvent:NoteEvent = new NoteEvent(NoteEvent.DELETE_NOTE, true, false);
				deleteEvent.data = this.id;
				dispatchEvent(deleteEvent);
			} else {
				var destroyEvent:NoteEvent = new NoteEvent(NoteEvent.DESTROY_NOTE, true, false);
				destroyEvent.data = this.id;
				dispatchEvent(destroyEvent);

				noteTF.content.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
				noteDelBtn.removeEventListener(MouseEvent.CLICK, onDelBtnClick);				
			}
		}

		private function onDelBtnClick(event:MouseEvent):void {
			fadeoutAnimation();
		}

		
		private function onFocusOut(event:FocusEvent):void {
			var noteData:Object = new Object();
			noteData.noteID = this.id;
			noteData.noteStatus = this.status;
			noteData.noteBody = noteTF.content.text;
			
			var editNoteEvent:NoteEvent = new NoteEvent(NoteEvent.EDIT_NOTE, false, false);
			editNoteEvent.data = noteData;
			dispatchEvent(editNoteEvent);
		}

		public function get content():String {
			_content = noteTF.content.text;
			return _content;
		}

		public function set content(content:String):void {
			_content = content;
			if(_content) noteTF.content.text = content;
		}

		
		public function set creationTime(creationTime:String):void {
			_creationTime = creationTime;
			noteTime.timeTF.text = _creationTime;
		}

		public function get creationDate():String {
			return _creationDate;
		}

		public function set creationDate(creationDate:String):void {
			_creationDate = creationDate;
			if(_creationDate) noteDate.content.text = _creationDate;
		}
	}
}
