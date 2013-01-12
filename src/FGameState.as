package  
{
	import flash.display.StageDisplayState;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import res.BG;
	import res.Sprt;
	import Script;
	/**
	 * ...
	 * @author Sean Hogan
	 */
	public class FGameState extends FlxState 
	{
		
		private var bg:FlxSprite = new FlxSprite;
		
		private var BRAD:FlxSprite = new FlxSprite;
		private var blues:FlxGroup = new FlxGroup;
		private var reds:FlxGroup = new FlxGroup;
		
		private var instructions:FlxText = new FlxText(0, 100, 2000, "blah");
		
		override public function create():void 
		{
			FlxG.bgColor = 0xffff0000;
			bg.loadGraphic(BG.test, false, false, 1280, 720);
			bg.velocity.x = 220;
			bg.velocity.y = 250;
			
			BRAD.loadGraphic(Sprt.char_130_150, true, false, 130, 150);
			BRAD.addAnimation("run", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26], 30);
			BRAD.play("run");
			BRAD.scale.x = BRAD.scale.y = 0.5;
			add(bg);
			add(BRAD);
			
			add(blues);
			add(reds);
			
			make_blue(25);
			make_red(10);
			
			add(instructions);
			instructions.text = "Press X to make more \"Water\"\nPress C to make more Tims";
				instructions.size = 50;
			
		}
		
		var old:Number 
		override public function update():void 
		{
			
		
			
			instructions.text = "Press X to make more \"Water\"\nPress C to make more Tims\n";
			if (FlxG.keys.DOWN) {
				BRAD.velocity.y = 100;
			} else if (FlxG.keys.UP) {
				BRAD.velocity.y = -100;
			}
			
			if (FlxG.keys.LEFT) {
				BRAD.velocity.x = -100;
			} else if (FlxG.keys.RIGHT) {
				BRAD.velocity.x = 100;
			}
			
			Script.bounce_in_box(bg, 1500, -500, 1400, -120);
			
			if (FlxG.keys.justPressed("X")) {
				make_blue(8);
			}
			if (FlxG.keys.justPressed("C")) {
				make_red(8);
			}
			
			for each (var blue:FlxSprite in blues.members) {
				if (blue != null) {
					if (blue.x > FlxG.width - blue.width && blue.facing == FlxObject.RIGHT) {
						blue.velocity.x *= -1;
						blue.facing = FlxObject.LEFT;
					} else if (blue.facing == FlxObject.LEFT && blue.x < 0) {
						blue.velocity.x *= -1;
						blue.facing = FlxObject.RIGHT;
					}
					
				}
			}
			for each (var red:FlxSprite in reds.members) {
				if (red != null) {
					Script.bounce_in_box(red, FlxG.width, 0, FlxG.height, 0);
				}
			}
			super.update();
		}
		
		private function make_red(nr:int):void {
			for (var i:int = 0; i < nr; i++) {
				var red:FlxSprite = new FlxSprite(Math.random() * FlxG.width, Math.random() * FlxG.height);
				red.loadGraphic(Sprt.char_130_150, true, false, 130, 150);
				red.addAnimation("walk", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26], 30);
				red.play("walk");
				reds.add(red);
				red.velocity.x = 100 + 200 * Math.random();
				red.velocity.y = 100 + 200 * Math.random();
			}
		}
		private function make_blue(nr:int):void {
			for (var i:int = 0; i < nr; i++) {
				var blue:FlxSprite = new FlxSprite(0 + 400*Math.random(), (FlxG.height - 300) + 250 * Math.random());
				blue.makeGraphic(100, 80, 0xff000055 + uint(0x90 * Math.random()));
				blues.add(blue);
				blue.facing = FlxObject.RIGHT;
				blue.velocity.x = 200 + 200 * Math.random();
			}
		}
	}

}