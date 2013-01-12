package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sean Hogan
	 */
	public class K 
	{

		public var U:Boolean;
		public var D:Boolean;
		public var L:Boolean;
		public var R:Boolean;

		public function update():void {
			U = FlxG.keys.UP;
			R = FlxG.keys.RIGHT;
			D = FlxG.keys.DOWN;
			L = FlxG.keys.LEFT;
		}
	}

}