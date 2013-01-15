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
		
		private var state:int = 0;
		private const S_INVISIBLE:int = 0;
		private const S_VISIBLE:int = 1;
		private const S_ON_PLAYER:int = 2;
		
		private var d_bot2ptop:Number;
		
		
		public function Island(worldx:int,worldy:int,_player:Player) 
		{
			x = worldx;
			y = worldy;
			player = _player;
			super(x,y);
			loadGraphic(Sprt.test_bone_island_508_236, false, false, 508, 236);
			
			mist = new FlxSprite(x, y);
			mist.makeGraphic(width, height, 0xff444444);
			mist.scrollFactor = new FlxPoint(1, 0.0);
		}
		
		override public function update():void 
		{
			if (state == S_INVISIBLE) {
				visible = false;
				if (player.x > x - (FlxG.width) && player.x < x + width + FlxG.width && player.y >= y - FlxG.height) {
					visible = true;
					state = S_VISIBLE;
				}
				super.update();
				return;
			} else {
				if (player.x < x - (FlxG.width) || player.x > x + width + FlxG.width || player.y < y - FlxG.height) {
					visible = false;
					state = S_INVISIBLE;
				}
			}
			
			if (state == S_ON_PLAYER) {
				
			} else if (state == S_VISIBLE) {
				d_bot2ptop = player.y - (y + height);
				
				// Chnage so if you touch the "entrance box" (right below the exit box)
				// THe player attaches to this island
				//Change camera deadzone so you can "walk" on the island
				if (d_bot2ptop < 0 && player.x < x + width && player.x > x) {
					state = S_ON_PLAYER;
					player.set_state_island(this);
				}	
			}
			
			
			
			
			
			super.update();
		}
		
	}

}