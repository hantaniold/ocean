package state 
{
	import ent.FlxSprite_Edge;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Sean Hogan
	 */
	public class S_Puz extends FlxState 
	{
		
		private var start_node:FlxSprite;
		private var end_node:FlxSprite;
		
		private var nodes:FlxGroup;
		private var quads:FlxGroup;
		private var empty_quads:Array;
		private var odd_quads:Array;
		private var even_quads:Array;
		
		private var odd_quads_nrs:Array;
		private var even_quads_nrs:Array;
		
		private var active_vertices:Array;
		private var active_edges:Array;
		
		private var bg:FlxSprite;
		
		private var mouse_detector:FlxObject;
		
		private var result_text:FlxText;
		
		override public function create():void 
		{
			nodes = new FlxGroup(9);
			quads = new FlxGroup(4);
			bg = new FlxSprite;
			bg.makeGraphic(32 * 3 + 64 * 2, 32 * 3 + 64 * 2, 0xff0000ff);
			add(bg);
			add(nodes);
			add(quads);
			
			mouse_detector = new FlxObject(0, 0, 2, 2);
			
			active_vertices = new Array();
			active_edges = new Array();
			
			odd_quads = new Array();
			even_quads = new Array();
			odd_quads_nrs = new Array(0,0);
			empty_quads = new Array(1, 2);
			even_quads_nrs = new Array(3,3);
			var s:FlxSprite;
			for (var i:int = 0; i < quads.maxSize; i++) {
				s = new FlxSprite;
				s.makeGraphic(64, 64, 0xff000000);
				s.visible = false;
				quads.add(s);
				s.x = 32 + 96 * (i % 2);
				s.y = 32 + 96 * int(i / 2);
				s.gx = (i % 2);
				s.gy = int(i / 2);
				if (odd_quads_nrs.indexOf(i) != -1) {
					odd_quads.push(s);
					s.makeGraphic(64, 64, 0xffffffff);
					s.visible = true;
				}
				if (even_quads_nrs.indexOf(i) != -1) {
					even_quads.push(s);
					s.makeGraphic(64, 64, 0xffff0000);
					s.visible = true;
				}
				
				s.debug_text = new FlxText(s.x, s.y, 50);
				s.debug_text.color = 0x000000;
				s.debug_text.size = 36;
				
				add(s.debug_text);
				
				
			}
			
			
			for (i = 0; i < nodes.maxSize; i++) {
				s = new FlxSprite;
				
				s.makeGraphic(32, 32, 0xff00ff00);
				
				
				nodes.add(s);
				s.x = 96 * (i % 3);
				s.y = 96 * int(i / 3);
				
				s.gx = (i % 3);
				s.gy = int(i / 3);
				
				if (i == 6) {
					start_node = s;
					s.debug_text = new FlxText(s.x, s.y, 100);
					s.debug_text.size = 25;
					s.debug_text.color = 0xff0000;
					s.debug_text.text = "1";
					add(s.debug_text);
				} else if (i == 0) {
					end_node = s;
					s.debug_text = new FlxText(s.x, s.y, 100);
					s.debug_text.text = "2";
					s.debug_text.size = 25;
					s.debug_text.color = 0xff0000;
					add(s.debug_text);
				}
			}
			
			
			result_text = new FlxText(20, 40, 500);
			result_text.size = 80;
			result_text.color = 0xff4444;
			add(result_text);
			FlxG.mouse.show();
			
			
		}
		
		private var prev_vertex:FlxSprite;
		override public function update():void 
		{
			super.update();
			
			
			var touched_vertex:FlxSprite;
			mouse_detector.x = FlxG.mouse.x;
			mouse_detector.y = FlxG.mouse.y;
			touched_vertex = get_first_overlap(mouse_detector, nodes) as FlxSprite;
			if (touched_vertex != null ) {
				
				if (false == is_vertex_in(active_vertices, touched_vertex) && (null == prev_vertex || are_vertices_adjacent(prev_vertex,touched_vertex))) {
					set_vertex(touched_vertex, true);
					if (prev_vertex != null) {
						active_edges.push(new FlxSprite_Edge(prev_vertex, touched_vertex));
					}
					
					prev_vertex = touched_vertex;
					active_vertices.push(touched_vertex); 
					
					
				}
			}
			
			
			for (var i:int = 0; i < quads.maxSize; i++  ) {
				var quad:FlxSprite = quads.members[i];
				if (quad != null && quad.visible) {
					var nr_none_crossings:int = 4 - how_many_crossings(active_edges, quad);
					quad.debug_text.text = nr_none_crossings.toString();
				}
			}
			
			// check to reset 
			
			if (FlxG.keys.justPressed("SPACE")) {
				active_edges = new Array();
				active_vertices = new Array();
				var win:Boolean = true;
				for each (var n:FlxSprite in nodes.members) {
					if (n != null && n.visible) {
						set_vertex(n, false);
						
					}
				}
				prev_vertex = null;
				
				for each (var q:FlxSprite in even_quads) {
					if (q != null) {
						trace("Even quad: ", parseInt(q.debug_text.text), " openings");
						if (parseInt(q.debug_text.text) % 2 != 0) {
							win = false;
						}
					}
				}
				for each (var q:FlxSprite in odd_quads) {
					if (q != null) {
						trace("Odd quad: ", parseInt(q.debug_text.text), " openings");
						if (parseInt(q.debug_text.text) % 2 != 1) {
							win = false;
						}
					}
				}
				
				result_text.visible = true;
				result_text.alpha = 1;
				if (win) {
					result_text.text = "WIN";
				} else {
					result_text.text = "LOSE";
				}
				
			}
			
			result_text.alpha -= 0.005;
			
			
		}
		
		// check extensions
		private function how_many_crossings(edge_set:Array, quad:FlxSprite):int {
			var cross_val:uint = 0;
			for each (var e:FlxSprite_Edge in edge_set) {
				cross_val |= e.crosses_quad_extension(quad);
			}
			
			var total:int = 0;
			if (cross_val & FlxObject.UP) total++;
			if (cross_val & FlxObject.DOWN) total++;
			if (cross_val & FlxObject.RIGHT) total++;
			if (cross_val & FlxObject.LEFT) total++;
			
			return total;
			
		}
		
		private function get_first_overlap(checker:FlxObject, checkees:FlxGroup):FlxObject {
			for (var i:int = 0; i < checkees.maxSize; i++) {
				if (checkees.members[i] != null) {
					if (checker.overlaps(checkees.members[i])) {
						return checkees.members[i];
					}
				}
			}
			return null;
		}
		
		private function is_vertex_in(some_set:Array, vertex:FlxSprite):Boolean {
			for (var i:int = 0; i < some_set.length; i++) {
				if (some_set[i] != null) {
					if (some_set[i].gx == vertex.gx && some_set[i].gy == vertex.gy) {
						return true;
					}
				}
			}
			return false;
		}
		private function are_vertices_adjacent(v1:FlxSprite, v2:FlxSprite):Boolean{
			if (Math.abs(v1.gx - v2.gx) + Math.abs(v1.gy - v2.gy) <= 1) {
				return true;
			}
			return false;
			
		}
		private function set_vertex(vertex:FlxSprite, activate:Boolean):void {
			if (activate) {
				vertex.makeGraphic(32, 32, 0xffcccccc);
			} else {
				vertex.makeGraphic(32, 32, 0xff00ff00);
			}
		}
	}

}