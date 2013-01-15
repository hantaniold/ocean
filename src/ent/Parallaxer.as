package ent 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import state.S_Ocean;
	
	public class Parallaxer extends FlxSprite 
	{
		
		/**
		 * World coordinates. These are used once _by is within 
		 * S_Ocean.h of player.y
		 * 
		 */
		protected var _wx:int; 
		protected var _wy:int;
	
		/**
		 * Distance from _by to player.y 
		 */
		protected var _d:int;
		
		/**
		 * The y-coord of the bottom of the sprite's hitbox.
		 */
		protected var _by:int;
		
		protected var _state:int;
		
		/**
		 * When being rendered but not in the no-scale region
		 */
		protected static const S_SCALE:int = 0;
		protected static const S_NO_SCALE:int = 1;
		/**
		 * off screen or too far away (don't bother drawing/scaling)
		 */
		protected static const S_INVISIBLE:int = 2;
		
		
		private var init:Boolean = false;
		
		public function Parallaxer(_world_x:int,_world_y:int)
		{
			_wx = _world_x;
			_wy = _world_y;
			super(_wx, _wy);
			
		}
		
		
		override public function update():void 
		{	
			_by = _wy + height;
			_d = (FlxG.camera.bottom) - _by;
			if (false == init) {
				init = true;
				
				// Finish later
				if (_d <= S_Ocean.h) {
					// Well maybe invisible
					_state = S_NO_SCALE;
				} else {
					scrollFactor.x = 0;
					scrollFactor.y = 0;
					_state = S_SCALE;
				}
			}
			
			
			if (_state == S_NO_SCALE) {
				_state_no_scale();
			} else if (_state == S_SCALE) {
				_state_scale();
			} else if (_state == S_INVISIBLE) {
				// check to switch
				var a:Number = _d - S_Ocean.h;
				var ew:int = S_Ocean.tantheta * a;
				
				
				if (_d <= S_Ocean.d_max &&
					(_wx + width) >= FlxG.camera.scroll.x - ew &&
					_wx <= FlxG.camera.scroll.x + FlxG.camera.width  + ew) 
				{
					visible = true;
					_state = S_SCALE;
				}
			}
			super.update();
		}
		
		protected function _state_no_scale():void {
			if (_d > S_Ocean.h) {
				_state = S_SCALE;
				scrollFactor.y = scrollFactor.x = 0;
				
			}
		}
		
		protected function _state_scale():void { 
			
			//first, get how far into the scaleable region (game-space)
			// The sprite to scale is.
			var a:Number = _d - S_Ocean.h;
			var ew:int = S_Ocean.tantheta * a;
			
			if (_d <= S_Ocean.h) {
				_state = S_NO_SCALE;
				scrollFactor.y = scrollFactor.x = 1;
				y = _wy;
				x = _wx;
				return;
			} else if (	_d > S_Ocean.d_max 							|| 
						_wx  < FlxG.camera.scroll.x - ew - width	||
						_wx > FlxG.camera.scroll.x + FlxG.camera.width + ew) {
				_state = S_INVISIBLE;
				visible = false;
				return;
			}
			
			// Compute a new scaling factor.
			a /= (S_Ocean.d_max - S_Ocean.h);
			scale.y = scale.x = S_Ocean.scale_min +  (1 - a) * (1 - S_Ocean.scale_min);
			
			// calculate x coord which is 
			var big_w:Number = 2 * ew + FlxG.camera.width + width;
			var ax:Number = _wx - (FlxG.camera.scroll.x  - ew - width);
			var p:Number = ax / big_w;
			x = -width + (p * (width + FlxG.camera.width));
			
			// Calculate the y coordinate, which is interpolated between
			// The screen-space horizon and the bottom of screen - S_Ocean.h 
			y = S_Ocean.HORIZON_Y + (1 - a) * (S_Ocean.h_scale_region);
			y -= height;
			
			// Keep the image flush with the bottom of the hitbox.
			offset.y = (height - (height * scale.y)) / -2;
			
			
		}
	}

}