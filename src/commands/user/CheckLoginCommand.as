package commands.user {
	import actors.DatabaseService;

	import events.UserEvent;

	import helpers.Logger;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Blase
	 */
	public class CheckLoginCommand extends Command {

		[Inject]
		public var userevent:UserEvent;

		[Inject]
		public var databaseservice:DatabaseService;

		[Inject]
		public var logger:Logger;	

		override public function execute():void {
			logger.log("checkLoginCommand with " + userevent.data.user + "/" + userevent.data.pass);
			databaseservice.requestLogin(userevent.data);
		}
	}
}
