package helpers {
	import flash.display.Sprite;
	import flash.utils.getTimer;

	/**
	 * @author Marvin
	 */
	public class Logger extends Sprite {
		public function Logger():void {
			
		}
		
		public function log(msg:String):void {
			trace(Math.floor(getTimer()) + "ms - " + msg);
		}
	}
}
