package actors {
	import events.NoteEvent;
	import events.UserEvent;

	import helpers.Debug;
	import helpers.Logger;

	import com.adobe.serialization.json.JSON;

	import org.robotlegs.mvcs.Actor;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * @author Blase
	 */
	public class DatabaseService extends Actor {
		public static const IDENT:String = "dataBase";

		[Inject]
		public var logger:Logger;

		[Inject]
		public var sharedobjectservice:SharedObjectService;

		
		private var _requestLoader:URLLoader;
		private var _requestURL:URLRequest;
		private var _requestVariables:URLVariables;
		private var _count:int;

		public function DatabaseService() {
			super();
			
			_requestURL = new URLRequest();
			_requestVariables = new URLVariables();
			_requestLoader = new URLLoader();
			_requestLoader.addEventListener(IOErrorEvent.IO_ERROR, onConnectError);
		}

		public function destroyNote(data:int):void {
			_requestVariables = new URLVariables();
			_requestVariables['noteID'] = data;
			
			_requestURL.url = "http://intern.notetomyself.com/html/res/php/note.php?type=destroy";
			_requestURL.data = _requestVariables;
			
			_requestLoader.addEventListener(Event.COMPLETE, onResponse);
			_requestLoader.load(_requestURL);		
		}

		private function onConnectError(event:IOErrorEvent):void {
			logger.log("connectionError!");
			
			var logoutSuccessEvent:UserEvent = new UserEvent(UserEvent.LOGOUT_SUCCESS, true, false);
			logoutSuccessEvent.data = "connectionFail";
			dispatch(logoutSuccessEvent);
		}

		public function requestLogin(data:Object):void {
			logger.log("requestLogin");
			
			// send data.user & data.pass to php
			
			
			for(var str:String in data) {
				_requestVariables[str] = data[str];
			}			
			
			if(data.type != "initialize") {
				_requestURL.url = "http://intern.notetomyself.com/html/res/php/user.php?type=login";			
				_requestURL.data = _requestVariables;
			} else {
				_requestURL.url = "http://intern.notetomyself.com/html/res/php/user.php?type=notes";
				_requestURL.data = _requestVariables;
			}
			
			
			_requestURL.method = URLRequestMethod.POST;
			_requestLoader.dataFormat = URLLoaderDataFormat.TEXT;
			
			_requestLoader.addEventListener(Event.COMPLETE, onResponse);
			_requestLoader.load(_requestURL);
		}

		
		private function onResponse(event:Event):void {
			_requestLoader.removeEventListener(Event.COMPLETE, onResponse);
			
			try {
				var tmpData:Object = JSON.decode(event.target.data);
				logger.log("onResponse: " + tmpData.response);
				
				//				Debug.dump(tmpData);

				var loginSuccessEvent:UserEvent = new UserEvent(UserEvent.LOGIN_SUCCESS, true, false);
				loginSuccessEvent.user = tmpData.userName;
				var logoutSuccessEvent:UserEvent = new UserEvent(UserEvent.LOGOUT_SUCCESS, true, false);
			
				switch(tmpData.response) {
					case "loginSuccess":
						loginSuccessEvent.data = JSON.decode(tmpData.notes);
						dispatch(loginSuccessEvent);
						break;
					
					case "getNotesSuccess":
						loginSuccessEvent.data = JSON.decode(tmpData.notes);
						dispatch(loginSuccessEvent);
						break;
						
					case "getNotesFail.noData":
						logoutSuccessEvent.data = "noSession";
						dispatch(logoutSuccessEvent);
						break;
						
					case "logoutSuccess":
						logoutSuccessEvent.data = "logoutSuccess";
						dispatch(logoutSuccessEvent);
						break;
						
					case "createSuccess":
						parseNoteData(JSON.decode(tmpData.notes));
						break;
					
					case "deleteSuccess":
						break;
						
					case "destroySuccess":
						break;
					
					case "updateSuccess":
						break;
				}
			} catch(e:Error) {
				//trace(event.target.data);
				logger.log(e.message);
			}
		}

		public function parseNoteData(data:Array):void {
			for(var str:String in data) {
				var tmpData:Object = new Object();
				tmpData.noteID = data[str].noteID;
				tmpData.noteBody = data[str].noteBody;
				tmpData.noteX = data[str].noteX;
				tmpData.noteY = data[str].noteY;
				tmpData.noteStatus = data[str].noteStatus;
				tmpData.creationTime = data[str].creationTime;
				tmpData.creationDate = data[str].creationDate;
				tmpData.status = data[str].noteStatus;
				
				_count = tmpData.noteID + 1;
			
				var noteParsedEvent:NoteEvent = new NoteEvent(NoteEvent.NOTEDATA_PARSED, true, false);
				noteParsedEvent.data = tmpData;
				
				dispatch(noteParsedEvent);	
			}
		}

		public function createNote(event:NoteEvent):void {
			_requestVariables = new URLVariables();
			
			for(var str:String in event.data) {
				_requestVariables[str] = event.data[str];
			}
			
			Debug.dump(_requestVariables);
			
			_requestURL.url = "http://intern.notetomyself.com/html/res/php/note.php?type=create";
			_requestURL.data = _requestVariables;
			
			_requestLoader.dataFormat = URLLoaderDataFormat.TEXT;
			
			_requestLoader.addEventListener(Event.COMPLETE, onResponse);
			_requestLoader.load(_requestURL);
		}

		public function removeNote(data:int):void {
			_requestVariables = new URLVariables();
			_requestVariables['noteID'] = data;
			
			_requestURL.url = "http://intern.notetomyself.com/html/res/php/note.php?type=delete";
			_requestURL.data = _requestVariables;
			
			_requestLoader.addEventListener(Event.COMPLETE, onResponse);
			_requestLoader.load(_requestURL);	
		}

		
		public function registerUser(data:Object):void {
			// send data.user & data.pass to php
			// await true/false
			// if false.userexists -> dispatch userevent
		}

		
		public function logOut():void {
			_requestURL.url = "http://intern.notetomyself.com/html/res/php/user.php?type=logout";
			_requestURL.data = _requestVariables;
			
			_requestLoader.addEventListener(Event.COMPLETE, onResponse);
			_requestLoader.load(_requestURL);	
		}

		
		public function editNote(event:NoteEvent):void {
			_requestVariables = new URLVariables();

			
			for(var str:String in event.data) {
				_requestVariables[str] = event.data[str];
			}
			
			
			_requestURL.url = "http://intern.notetomyself.com/html/res/php/note.php?type=update";
			_requestURL.data = _requestVariables;
			
			_requestLoader.addEventListener(Event.COMPLETE, onResponse);
			_requestLoader.load(_requestURL);	
		}
	}
}
