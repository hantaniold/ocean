package state 
{
	import ent.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import res.BG;
	import res.Sprt;
	
	public class S_Ocean extends FlxState 
	{
		private var bg:FlxSprite;
		private var island:FlxSprite;
		private var player:Player;
		
		private const HORIZON_Y:int = 453;
		
		override public function create():void 
		{
			bg = new FlxSprite(0, 0);
			bg.loadGraphic(BG.test_ocean, false, false, 1280, 720);
			bg.scrollFactor = new FlxPoint(0, 0);
			add(bg);
			
			island = new FlxSprite(0, 0);
			island.loadGraphic(Sprt.test_island_811_410, false, false, 811, 410);
			add(island);
			
			player = new Player();
			add(player);
			FlxG.camera.follow(player);
			FlxG.camera.deadzone = new FlxRect(300, HORIZON_Y, 600, 250);
		}
		
		
		override public function destroy():void 
		{
			super.destroy();
			bg = null;
		}
		
		override public function update():void 
		{
			
			super.update();
		}
		
	}

}