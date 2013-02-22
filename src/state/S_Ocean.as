package state 
{
	import ent.Island;
	import ent.Parallaxer;
	import ent.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
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
		
		/**
		 * The screen-space coordinate of the horizon y value
		 */
		public static const HORIZON_Y:int = 240;
		public static const EXTRA_PLAYER_DEADZONE_WIDTH:int = 40;
		public static const EXTRA_PLAYER_DEADZONE_HEIGHT:int = 40;
		
		/**
		 * Maximum world-space distance (measured from the top of the player sprite)
		 * from which an object will be rendered - only relevant to "moving into the horizon".
		 */
		public static const d_max:int = 1300;
		/**
		 * Height of the space, measured from the bottom of the screen
		 * from which an object whose max y-coord will be rendered normally (no scaling or parallax)
		 */
		public static const h:int = 200; 
		
		/**
		 * Height of the space w/ dynamic parallax.
		 * this is just FlxG.height - S_ocean.h - S_ocean.HORIZON_Y
		 */
		public static const h_scale_region:int = 720 - 200 - 240;
		
		
		/**
		 * Angle swept out from the 
		 */
		public static const theta:Number = 3.14 * (1/3); 
		public static var tantheta:Number;
		
		/**
		 * The scaling of an object rendered at maximum distance.
		 */
		public static const scale_min:Number = 0.1;
		
		
		public static var parallaxers:FlxGroup;
		
		override public function create():void 
		{
			tantheta = Math.tan(theta);
			
			bg = new FlxSprite(0, 0);
			bg.loadGraphic(BG.test_ocean, false, false, 1280, 720);
			bg.scrollFactor = new FlxPoint(0, 0);
			add(bg);
			
			player = new Player();
			player.x = 200;
			player.y = 700;
			FlxG.camera.setBounds(-1000, -1000, 5000, 5000);
			FlxG.camera.follow(player);
			FlxG.camera.deadzone = new FlxRect((FlxG.width - player.width) / 2 - EXTRA_PLAYER_DEADZONE_WIDTH, 560 - EXTRA_PLAYER_DEADZONE_HEIGHT, player.width + 2*EXTRA_PLAYER_DEADZONE_WIDTH, player.height + 2*EXTRA_PLAYER_DEADZONE_HEIGHT);
			
			// Islands are fixed? (In game space)
			island = new Island(0, 0,player);
			add(island);
			
			parallaxers = new FlxGroup;
			for (var i:int = 0; i < 50; i++) {
				var p:Parallaxer = new Parallaxer(-500 + 3200 * Math.random(), -400 + 1600 * Math.random());
				p.loadGraphic(Sprt.char_130_150, false, false, 130, 150);
				parallaxers.add(p);
			}
			
			add(parallaxers);
			//add(island.mist);
			add(player);
		}
		
		override public function draw():void 
		{
			parallaxers.sort("y_graphic_bottom");
			super.draw();
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