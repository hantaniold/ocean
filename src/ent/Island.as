package ent 
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import res.Sprt;
	import state.S_Ocean;
	
	/**
	 * ...
	 * @author Sean Hogan
	 */
	public class Island extends FlxSprite 
	{
		
		public var world_x:int;
		public var world_y:int;
		public var player:Player;
		public var mist:FlxSprite;
		
		private const FADE_DOWN_D:Number = 300;
		private const FAR_SCALE_MIN:Number = 0.8;
		private var SHORE_HORIZON_GAP:Number;
		private var SHORE_BOTTOM_GAP:Number;
		
		// Distance is bottom of island to top of player hitbox
		private const D_MIST_IN:Number = 500; // When mist should start fading in for an island
		private const D_MIST_HOLD:Number = 320; // When mist should stay at alpha 1 for an island
		private const D_MIST_OUT:Number = 150; // When mist should start fading out
		private const D_MIST_GONE:Number = 50; // Whem ist should be gone
		
		private var state:int = 0;
		private const S_INVISIBLE:int = 0;
		private const S_VISIBLE:int = 1;
		
		private var d:Number;
		
		
		public function Island(worldx:int,worldy:int,_player:Player) 
		{
			x = worldx;
			y = worldy;
			player = _player;
			SHORE_BOTTOM_GAP = 150;
			SHORE_HORIZON_GAP = FlxG.height - S_Ocean.HORIZON_Y - SHORE_BOTTOM_GAP;
			super(0,0);
			loadGraphic(Sprt.test_island_811_410, false, false, 811, 410);
			
			mist = new FlxSprite(x, y);
			mist.makeGraphic(width, height, 0xff444444);
			mist.scrollFactor = new FlxPoint(1, 0.0);
		}
		
		override public function update():void 
		{
			if (state == S_INVISIBLE) {
				visible = false;
				if (player.x > x - (FlxG.width) && player.x < x + width + FlxG.width) {
					visible = true;
					state = S_VISIBLE;
				}
				super.update();
				return;
			} else {
				if (player.x < x - (FlxG.width) || player.x > x + width + FlxG.width) {
					visible = false;
					state = S_INVISIBLE;
				}
			}
			
			mist.y = y;
			mist.scale.x -= 0.001;
			if (player.y > y + height - player.height) { // Below
				d = player.y - (y + height);
				alpha = 1 - (d / FADE_DOWN_D);
				alpha += 0.1;
 				
				if (d > 500) {
					mist.alpha = alpha = 0;
					//dont do anyting
				} else if (d > 300) {
					alpha = 0;
					mist.alpha = (500 - d) / 200.0;
					// fade mist in
				} else if (d > 100) {
					alpha = 0;
					// mist alpha at 1
				} else if (d > 50) {
					mist.alpha = 1 - ((100 -d) / 50.0)
					//mist fades out
				}
				
				
			} else if (player.y < y) { // Above
				scale.x = scale.y = 1;
				alpha = 1;
			} else { // In between, or "on"
				if (player.is_island_state() == false) {
					player.set_state_island();
				}
				y = FlxG.height - SHORE_BOTTOM_GAP - height;
				scale.x = scale.y = 1;
				alpha = 1;
			}
			
			
			
			super.update();
		}
		
	}

}