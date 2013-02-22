package ent 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Sean Hogan
	 */
	public class FlxSprite_Edge 
	{
		
		public var v1:FlxSprite;
		public var v2:FlxSprite;
		public var lo_x:int;
		public var lo_y:int;
		public var hi_x:int;
		public var hi_y:int;
		public function FlxSprite_Edge(_v1:*,_v2:*) 
		{
			v1 = _v1;
			v2 = _v2;
			
			if (v1.gx < v2.gx) {
				lo_x = v1.gx;
				hi_x = v2.gx;
			} else {
				lo_x = v2.gx;
				hi_x = v1.gx;
			}
			
			if (v1.gy < v2.gy) {
				lo_y = v1.gy;
				hi_y = v2.gy;
			} else {
				lo_y = v2.gy;
				hi_y = v1.gy;
			}
		}
		
		public function crosses_quad_extension(quad:FlxSprite):uint {
			if (quad.gx >= lo_x && quad.gx < hi_x) {
				if (quad.gy >= lo_y) {
					return FlxObject.UP;
				} else {
					return FlxObject.DOWN;
				}
			} else if (quad.gy >= lo_y && quad.gy < hi_y) {
				if (quad.gx >= lo_x) {
					return FlxObject.LEFT;
				} else {
					return FlxObject.RIGHT;
				}
			}
			
			return FlxObject.NONE;
		}
	}

}