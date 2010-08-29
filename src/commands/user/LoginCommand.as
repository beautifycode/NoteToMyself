package commands.user {
	import actors.DatabaseService;
	import actors.SharedObjectService;

	import events.UserEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Blase
	 */
	public class LoginCommand extends Command {
		[Inject]
		public var databaseservice:DatabaseService;

		[Inject]
		public var userevent:UserEvent;
		
		[Inject]
		public var sharedobjectservice:SharedObjectService;

		[Inject]
		public var logger:Logger;	

		override public function execute():void {
			logger.log("loginCommand");
			
			sharedobjectservice.loggedIn = true;
			databaseservice.parseNoteData(userevent.data);		
		}
	}
}
