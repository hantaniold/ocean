package state 
{
	import ent.Island;
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
		private var island:Island	;
		private var player:Player;
		
		public static const HORIZON_Y:int = 453;
		
		override public function create():void 
		{
			bg = new FlxSprite(0, 0);
			bg.loadGraphic(BG.test_ocean, false, false, 1280, 720);
			bg.scrollFactor = new FlxPoint(0, 0);
			add(bg);
			
			player = new Player();
			player.x = 0;
			player.y = 700;
			FlxG.camera.follow(player);
			FlxG.camera.deadzone = new FlxRect((FlxG.width - player.width) / 2, HORIZON_Y + 100, player.width, player.height);
			
			// Islands are fixed? (In game space)
			island = new Island(0, 0,player);
			add(island);
			
			add(island.mist);
			add(player);
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