package actors {
	import events.NoteEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Actor;

	import flash.net.SharedObject;

	/**
	 * @author Marvin
	 */
	 
	// service class for handling any request to sharedobject
	// is firstly called to readout existing data

	public class SharedObjectService extends Actor {
		[Inject]
		public var logger:Logger;
		
		public var sharedObject:SharedObject;
		public var count:int;
		public var loggedIn:Boolean;


		public function SharedObjectService() {
			sharedObject = SharedObject.getLocal('notedata', "/", false);
			
//			sharedObject.clear();
			if(sharedObject.data.devState != "2503") {
//				logger.log("clearingSharedObject");
			}
			
			sharedObject.data.devState = "2503";
			
			if(!sharedObject.data.notes) sharedObject.data.notes = new Object();
			sharedObject.flush();

			super();
		}

		
		public function requestData():void {
			for(var str:String in sharedObject.data.notes) {
				var tmpData:Object = new Object();
				tmpData.noteID = sharedObject.data.notes[str].noteID;
				tmpData.noteBody = sharedObject.data.notes[str].noteBody;
				tmpData.noteX = sharedObject.data.notes[str].noteX;
				tmpData.noteY = sharedObject.data.notes[str].noteY;
				tmpData.noteStatus = sharedObject.data.notes[str].noteStatus;
				tmpData.creationTime = sharedObject.data.notes[str].creationTime;
			
				var noteReadEvent:NoteEvent = new NoteEvent(NoteEvent.NOTEDATA_PARSED, true, false);
				noteReadEvent.data = tmpData;
				
				count = tmpData.noteID + 1;
				dispatch(noteReadEvent);	
			}
		}

		
		public function createNote(event:NoteEvent):void {
			var creationTime:Date = new Date();
			var correctHours:String = String(creationTime.hours);
			var correctMins:String = String(creationTime.minutes);
			
			if(creationTime.hours < 10) {
				correctHours = "0" + creationTime.hours;
			}
			if(creationTime.minutes < 10) {
				correctMins = "0" + creationTime.minutes;
			}

			sharedObject.data.notes[count] = event.data;
			sharedObject.data.notes[count].creationTime = correctHours + ":" + correctMins;
			
			sharedObject.flush();			
			event.data.noteID = count;
			event.data.noteStatus = 1;
			event.data.creationTime = correctHours + ":" + correctMins;

			count++;
			
			event.cType = NoteEvent.NOTEDATA_PARSED;
			dispatch(event);
		}

		public function editNote(event:NoteEvent):void {
			for(var str:String in event.data) {
				sharedObject.data.notes[event.data.noteID][str] = event.data[str];
			}
		}

		
		public function removeNote(id:int):void {
			sharedObject.data.notes[id]['noteStatus'] = 0;
		}

		public function destroyNote(id:int):void {
			delete sharedObject.data.notes[id];
		}
	}
}