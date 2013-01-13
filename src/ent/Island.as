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
		
		private const FADE_DOWN_D:Number = 300;
		private const FAR_SCALE_MIN:Number = 0.1;
		private var SHORE_HORIZON_GAP:Number;
		private var SHORE_BOTTOM_GAP:Number;
		
		private var d:Number;
		public function Island(worldx:int,worldy:int,_player:Player) 
		{
			world_x = worldx;
			world_y = worldy;
			player = _player;
			SHORE_BOTTOM_GAP = 150;
			SHORE_HORIZON_GAP = FlxG.height - S_Ocean.HORIZON_Y - SHORE_BOTTOM_GAP;
			super(0,0);
			loadGraphic(Sprt.test_island_811_410, false, false, 811, 410);
			x = 50;
			y = FlxG.height - height;
			
			scrollFactor = new FlxPoint(1, 0);
		}
		
		override public function update():void 
		{
			
			if (player.y > world_y + height) { // Below
				d = player.y - (world_y + height);
				alpha = 1 - (d / FADE_DOWN_D);
				scale.x = scale.y = FAR_SCALE_MIN + alpha * (1 - FAR_SCALE_MIN); // 0.2 to 1
			
				// the distance between the bottom of the scale dimage and its hitbox
				var a:Number = (height - (height * scale.y)) /  2;
				// Where the bottom of the island image (rather than its hitbox) should sit
				// lerp via scale
				var dest:Number = S_Ocean.HORIZON_Y + ((scale.x - FAR_SCALE_MIN) / (1 - FAR_SCALE_MIN)) * SHORE_HORIZON_GAP;
				trace(dest);
				y = dest - height + a;
				
			} else if (player.y < world_y) { // Above
				
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