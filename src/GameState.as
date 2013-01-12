package  
{
	/**
	 * ...
	 * @author Sean Hogan
	 */
	import org.axgl.Ax;
	import org.axgl.AxState;
	import org.axgl.render.AxColor;
	
	public class GameState  extends AxState
	{
		override public function create():void 
		{
			Ax.background = new AxColor(1, 0, 0);
		}
		
	}

}