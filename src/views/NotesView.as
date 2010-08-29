package views {
	import helpers.Logger;

	import views.freeview.view.FreeView;
	import views.trashview.view.TrashView;

	import com.greensock.TweenLite;
	import com.greensock.easing.Back;

	import flash.display.Sprite;

	/**
	 * @author Marvin
	 */
	public class NotesView extends Sprite {
		public var freeview:FreeView;
		public var trashview:TrashView;
		
		[Inject]
		public var logger:Logger;
		
		public function NotesView() {
			freeview = new FreeView();
			addChild(freeview);
			
			trashview = new TrashView();
			trashview.x = 2000;
			addChild(trashview);
		}
		
		public function switchView(view:String):void {
//			logger.log("switchView to " + view);
			
			switch(view) {
				case "trashview":
				TweenLite.to(freeview, .75, {x:-2000, ease:Back.easeIn});
				TweenLite.to(trashview, .5, {x:0, delay:.5});
				break;
				
				case "freeview":
				TweenLite.to(trashview, .75, {x:-2000, ease:Back.easeIn});
				freeview.x = 2000;
				TweenLite.to(freeview, .5, {x:0, delay:.5});
				break;
			}
		}
	}
}
