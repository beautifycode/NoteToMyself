package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author Marvin
	 */
	public class Main extends Sprite {
		private var context:MainContext;
		
		public function Main() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			context = new MainContext(this);	
		}
	}
}