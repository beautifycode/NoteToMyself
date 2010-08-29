package views.freeview.view {
	import components.Note;

	import events.NoteEvent;
	import events.ViewEvent;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Marvin
	 */
	public class FreeView extends Sprite {
		public var noteArea:Sprite;
		private var notesContainer:Sprite;

		
		public function FreeView() {
			noteArea = new Sprite();
			noteArea.graphics.beginFill(0xFF0000, 0);
			noteArea.graphics.drawRect(0, 0, 1, 1);
			noteArea.graphics.endFill();
			noteArea.doubleClickEnabled = true;
			
			noteArea.addEventListener(MouseEvent.DOUBLE_CLICK, onAreaViewClick);
			
			addChild(noteArea);
			
			notesContainer = new Sprite();
			addChild(notesContainer);
		}

		
		public function onResize(sizes:Object):void {
			noteArea.width = sizes.right;
			noteArea.height = sizes.bottom - 145;			
		}

		public function removeNote(data:int):void {
			for(var i:int;i < notesContainer.numChildren;i++) {
				if((notesContainer.getChildAt(i) as Note).id == data) {
					notesContainer.removeChild(notesContainer.getChildAt(i));
				}
			}		
		}

		public function addNote(note:Note):void {
			note.visible = true;
			note.alpha = 1;
			note.noteIcon.addEventListener(MouseEvent.MOUSE_DOWN, onIconDown);
			note.noteIcon.addEventListener(MouseEvent.MOUSE_UP, onIconUp);
			
			notesContainer.addChild(note);
			
			if(note.content == "") stage.focus = note.noteTF.content;
		}

		private function onIconDown(event:MouseEvent):void {
			event.target.addEventListener(Event.ENTER_FRAME, onDragging);
		}

		private function onIconUp(event:MouseEvent):void {
			event.target.removeEventListener(Event.ENTER_FRAME, onDragging);
			
			var noteReference:Note = event.target.parent;
			
			var roundX:int = Math.round(noteReference.x / 30) * 30;
			var roundY:int = Math.round(noteReference.y / 10) * 10;

			TweenMax.to(noteReference, .5, {x:roundX, y:roundY});
			
			
			var noteData:Object = new Object();
			noteData.noteID = noteReference.id;
			noteData.noteStatus = noteReference.status;
			noteData.noteX = roundX;
			noteData.noteY = roundY;
			
			var editNoteEvent:NoteEvent = new NoteEvent(NoteEvent.EDIT_NOTE, true, false);
			editNoteEvent.data = noteData;
			
			dispatchEvent(editNoteEvent);
		}

		
		private function onDragging(event:Event):void {
			var noteReference:Note = event.target.parent;
			
			noteReference.x += (this.mouseX - noteReference.x) * 0.2 - 4;
			noteReference.y += (this.mouseY - noteReference.y) * 0.2 + 5;
		}

		
		private function onAreaViewClick(event:MouseEvent):void {
			if(!event.altKey) {
				var tmpObj:Object = new Object();
				tmpObj.noteX = this.mouseX;
				tmpObj.noteY = this.mouseY;
			
			
				var areaClickEvent:NoteEvent = new NoteEvent(NoteEvent.CREATE_NOTE, false, false);
				areaClickEvent.data = tmpObj;
			
				dispatchEvent(areaClickEvent);
			} else {
				var switchViewEvent:ViewEvent = new ViewEvent(ViewEvent.SWITCH_TO_TRASHVIEW, true, false);
				switchViewEvent.data = "trashview";
				dispatchEvent(switchViewEvent);
			}
		}

		public function deleteNotes():void {
			for(var i:int;i < notesContainer.numChildren;i++) {
				var tmpNote:MovieClip = notesContainer.getChildAt(i) as MovieClip;
				TweenMax.to(tmpNote, .25, {autoAlpha:0});
			}
		}
	}
}
