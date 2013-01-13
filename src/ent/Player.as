package ent 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite 
	{
		
		private var k:K;
		public var state:int = 0;
		public function Player() 
		{
			k = Reg.k;
			makeGraphic(64, 128, 0xff123123);
		}
		
		private const S_SWIM:int = 0;
		private const S_ISLAND:int = 1;
		
		private const vert_base_spd:int = 40;
		private const hori_base_spd:int = 130;
		override public function update():void 
		{
			if (k.D) {
				velocity.y = vert_base_spd;
			} else if (k.U) {
				velocity.y = -vert_base_spd;
			} else {
				velocity.y = 0;
			}
			
			if (k.L) {
				velocity.x = -hori_base_spd;
			} else if (k.R) {
				velocity.x = hori_base_spd;
			} else {
				velocity.x = 0;
			}
			
			if (state == S_ISLAND) {
				// how to get off island...
			}
			
			if (FlxG.keys.SHIFT) {
				velocity.x *= 3;
				velocity.y *= 3;
			}
			super.update();
		}
		
		public function is_island_state():Boolean {
			return (state == S_ISLAND);
		}
		public function set_state_island():void {
			state = S_ISLAND;
			FlxG.camera.deadzone.y -= 600;
			FlxG.camera.deadzone.height += 600;
			FlxG.camera.deadzone.x -= 300;
			FlxG.camera.deadzone.width += 600;
		}
	}

}