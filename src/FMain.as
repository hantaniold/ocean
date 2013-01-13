package  
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.display.StageDisplayState;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import state.S_Ocean;
	/**
	 * ...
	 * @author Sean Hogan
	 */
	public class FMain extends FlxGame
	{
		[SWF(width = "1280", height = "720", backgroundColor = "#ff0000")]
		
		public function FMain() 
		{
			super(1280, 720, S_Ocean, 1, 60, 30);
			Reg.init();
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			// Center game
			
			x = (stage.fullScreenWidth - FlxG.width) / 2;
			y = (stage.fullScreenHeight - FlxG.height) / 2;
			
			FlxG.debug = true;
		}
		
		override protected function update():void 
		{
			
			x = (stage.fullScreenWidth - FlxG.width) / 2;
			y = (stage.fullScreenHeight - FlxG.height) / 2;
			
			if (FlxG.keys.justPressed("ESCAPE")) {
				NativeApplication.nativeApplication.exit();
			}
			Reg.k.update();
			super.update();
		}
	}

}