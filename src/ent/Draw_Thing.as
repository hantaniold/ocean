package ent 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Sean Hogan
	 */
	public class Draw_Thing extends FlxSprite 
	{
		
		private const stamp_size:int = 32;
		
		public function Draw_Thing(w:int,h:int,xx:int,yy:int) 
		{
			super(xx, yy);
			makeGraphic(w, h, 0x00ffffff);
			
			
		}
		
	}

}