package ent 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite 
	{
		
		private var k:K;
		public var state:int = 0;
		
		private var mid_x:int;
		private var mid_y:int;
		public function Player() 
		{
			k = Reg.k;
			makeGraphic(50, 100, 0xff123123);
		}
		
		private const S_SWIM:int = 0;
		private const S_ISLAND:int = 1;
		
		private const vert_base_spd:int = 40;
		private const hori_base_spd:int = 130;
		override public function update():void 
		{
			
			if (state == S_ISLAND) {
				mid_x = x + (width / 2); // For collisions/?
				mid_y = y + (height / 2);
				swim_movement(); // change
				// Check for colliding  with upp
				// If you touch the exit box then leave this island
				// how to get off island...
			} else if (state == S_SWIM) {
				swim_movement();
			}
			
			if (FlxG.keys.SHIFT) {
				velocity.x *= 10;
				velocity.y *= 10;
			}
			super.update();
		}
		
		public function swim_movement():void {
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
		}
		public function is_island_state():Boolean {
			return (state == S_ISLAND);
		}
		public function set_state_island(island:Island):void {
			state = S_ISLAND;
			FlxG.camera.deadzone.y -= 600;
			FlxG.camera.deadzone.height += 600;
			FlxG.camera.deadzone.x -= 300;
			FlxG.camera.deadzone.width += 600;
			// Set collision variables 
			// Upper edge (draw these?)
			// Lower edge
			// Right edge, left edge
			// Exit box area
			// Fade in any relevant NPCs or obstacles
		}
	}

}