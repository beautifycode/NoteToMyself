package commands {
	import actors.DatabaseService;
	import actors.SharedObjectService;

	import helpers.Logger;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Marvin
	 */
	// command to readout db / sharedobject at startup
	public class InitializeCommand extends Command {
		[Inject]
		public var sharedobjectservice:SharedObjectService;

		[Inject]
		public var databaseservice:DatabaseService;

		[Inject]
		public var logger:Logger;

		
		override public function execute():void {
			logger.log("initCommand");

			var tmpObj:Object = new Object();
			tmpObj.type = "initialize";
			
			try {
				databaseservice.requestLogin(tmpObj);
			} catch(e:Error) {
				trace(e);
			}
		}
	}
}
