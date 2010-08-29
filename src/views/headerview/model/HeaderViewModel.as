package views.headerview.model {
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Blase
	 */
	public class HeaderViewModel extends Actor {
		private var headerMsg:String;
		
		public function HeaderViewModel() {
			
		}
				
		public function updateHintState(data:*):void {
				headerMsg = "test";
		}
	}
}
