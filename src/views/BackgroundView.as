package views {
	import com.greensock.TweenMax;

	import flash.display.Sprite;

	/**
	 * @author Blase
	 */
	public class BackgroundView extends Sprite {

		[Embed(source="../../lib/img/bg.jpg")]
		private var bgAsset:Class;

		[Embed(source="../../lib/img/head.jpg")]
		private var logoAsset:Class;
		private var _bg:Sprite;
		private var _bgBitmap:*;
		private var _logo:Sprite;
		private var _logoBitmap:*;
		
		private var _cloud:CloudAsset;
		private var _trashSprite:Sprite;

		
		
		public function BackgroundView() {
			_trashSprite = new Sprite();
			_trashSprite.graphics.beginFill(0x000000);
			_trashSprite.graphics.drawRect(0,0,30,30);
			_trashSprite.graphics.endFill();
			
			
			
			_bg = new Sprite();
			_bgBitmap = new bgAsset();
			
			_bg.graphics.beginBitmapFill(_bgBitmap.bitmapData, null, false);
			_bg.graphics.drawRect(0, 0, 1000, 1000);
			_bg.graphics.endFill();
			
			addChild(_bg);
			
			_logo = new Sprite();
			_logoBitmap = new logoAsset();
			
			_logo.x = 0;
			_logo.y = 54;
			_logo.addChild(_logoBitmap);
			
			addChild(_logo);
			
			_cloud = new CloudAsset();
			addChild(_cloud);
			
//			addChild(_trashSprite);
		}
		
		public function addCloud():void {
			TweenMax.to(_cloud, 1, {autoAlpha:1});
		}

		public function removeCloud():void {
			TweenMax.to(_cloud, .25, {autoAlpha:0});
		}

		public function onResize(sizes:Object):void {
			_bg.width = sizes.right;
			_logo.x = (sizes.right / 2) - (_logoBitmap.width / 2);
			
			_trashSprite.x = (sizes.right / 2) - (_trashSprite.width / 2);
			_trashSprite.y = (sizes.bottom) - _trashSprite.height;
			
			
			_cloud.x = (sizes.right / 2) - (_cloud.width / 2);
			_cloud.y = (sizes.bottom / 2) - (_cloud.height / 2) + 100;
		}
	}
}
