package  
{
	import org.flixel.FlxSprite;
	public class Script 
	{
		
		/**
		 * Keeps a sprite's hitbox entirely in the specified
		 * box, and flips its velocities when needed to keep it inside the box.
		 * @return RES, where RES = X_FLIP | Y_FLIP, where X_FLIP = 0b01, Y_FLIP = 0b10
		 */
		public static function bounce_in_box(o:FlxSprite, x_max:int, x_min:int, y_max:int, y_min:int):int {
				var res:int = 0;
				if (o.velocity.x < 0) {
					if (o.x < x_min) {
						o.velocity.x *= -1; res |= 1;
					}
				} else {
					if (o.x + o.width > x_max) {
						o.velocity.x *= -1; res |= 1;
					}
				}
				
				if (o.velocity.y < 0) {
					if (o.y < y_min) {
						o.velocity.y *= -1; res |= 2;
					} 
				} else {
					if (o.y + o.height > y_max) {
						o.velocity.y *= -1; res |= 2;
					}
				}
				return res;
		}
	}

}