package views.headerview.view {
	import events.ResizeEvent;
	import events.UserEvent;

	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Sine;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Blase
	 */
	public class HeaderView extends Sprite {

		private var formular:FormularAsset;
		private var logout:LogoutAsset;
		private var hint:HintAsset;

		public function HeaderView() {
			hint = new HintAsset();
			hint.x = 20;
			hint.y = 25;
			hint.alpha = 0;
			addChild(hint);
			
			logout = new LogoutAsset();
			logout.addEventListener("onLogout", onLogout);
			logout.alpha = 0;
			addChild(logout);
			
			formular = new FormularAsset();
			formular.addEventListener("onSubmit", onSubmit);
			formular.alpha = 0;
			addChild(formular);
		}

		private function onLogout(event:Event):void {
			var logoutEvent:UserEvent = new UserEvent(UserEvent.LOGOUT_REQUEST, true, false);
			dispatchEvent(logoutEvent);	
		}

		private function onSubmit(event:Event):void {
			var tmpObj:Object = formular.tmpObj;
			
			var checkLoginEvent:UserEvent = new UserEvent(UserEvent.LOGIN_REQUEST, true, false);
			checkLoginEvent.data = tmpObj;
			dispatchEvent(checkLoginEvent);
		}

		public function updateHintState(msg:String):void {
			TweenMax.to(hint, .45, {y:30, ease:Back.easeInOut, alpha:1, onComplete:tweenFinish});
			hint.hintTF.content.text = msg;
		}

		private function tweenFinish():void {
			TweenMax.to(hint, .25, {y:25, ease:Sine.easeOut, alpha:1, onComplete:tweenFinish});
		}

		public function onResize(event:ResizeEvent):void {
			formular.x = event.right - formular.width - 15;
			formular.y = 15;
			
			logout.x = event.right - 20;
			logout.y = 19;
		}

		public function switchLoginState(loggedIn:Boolean, userName:String):void {
			if(loggedIn) {
				TweenMax.to(formular, .5, {delay:.5, autoAlpha:0, y:"-10", ease:Back.easeIn});
				
				logout.logoutTF.content.text = "Logged in as " + userName + ".";
				TweenMax.to(logout, .5, {delay:1, autoAlpha:1, ease:Back.easeIn});
			} else {
				TweenMax.to(formular, .5, {delay:.5, autoAlpha:1, y:"10", ease:Back.easeOut});
				
				TweenMax.to(logout, .5, {autoAlpha:0, ease:Back.easeIn});				
			}
		}
	}
}
