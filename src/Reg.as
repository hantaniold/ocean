package  
{
	/**
	 * ...
	 * @author Sean Hogan
	 */
	public class Reg
	{
		public static var k:K;
		private static var init_protect:Boolean = false;
		public static function init():void {
			if (init_protect) return;
			init_protect = true;
			k = new K;
		}
	}

}