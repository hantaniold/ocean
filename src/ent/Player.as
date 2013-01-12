package ent 
{
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite 
	{
		
		private var k:K;
		public function Player() 
		{
			k = Reg.k;
			makeGraphic(64, 128, 0xff123123);
		}
		
		private const vert_base_spd:int = 50;
		private const hori_base_spd:int = 100;
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
			super.update();
		}
		
	}

}