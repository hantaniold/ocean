package {
	import data.Common_Sprites;
	import data.NPC_Data;
	import data.SoundData;
	import entity.enemy.crowd.Person;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeWindowIcon;
	import flash.desktop.SystemIdleMode;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.events.VideoEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import global.*;
	import helper.DH;
	import helper.S_NPC;
	import org.flixel.*;
	import states.*;
	public class Intra extends FlxGame {
		
		public static var scale_ctr:int = 0;
		public var did_init_fullscreening:Boolean = false;
		public var IS_AIR:Boolean = true;
		private var full_scale_offset:Point = new Point(0, 0);
		private var ratio:Number;
		private var is_landscape:Boolean = true;
		public static var frame_x_px:int = 8; // Extra pixels
		public static var frame_y_px:int = 26;
		public static var did_window_config:Boolean = false;
		
		public static var is_release:Boolean = false;
		public static var is_demo:Boolean = false;
		public static var is_secret_press:Boolean = false;
		public static var is_sean:Boolean = false;
		public static var is_test:Boolean = false;
		public static var allow_fuck_it_mode:Boolean = false;
		private var did_init_window_fix:Boolean = false;
		
		private var did_mobile_setup:Boolean = false;
		public static var is_mobile:Boolean = false;
		public static var mobile_is_rhand:Boolean = true;
		
		public static var force_scale:Boolean = false;
		public static var scale_factor:int = 3;
		public static const SCALE_TYPE_WINDOWED:int = 0;
		public static const SCALE_TYPE_INT:int = 1;
		public static const SCALE_TYPE_FIT:int = 2;
		
		// Hitboxes
		public var up_sprite:Bitmap;
		public var down_sprite:Bitmap;
		public var left_sprite:Bitmap;
		public var right_sprite:Bitmap;
		
		public var a1_sprite:Bitmap;
		public var a2_sprite:Bitmap;
		public var pause_sprite:Bitmap;

		
		// Actual gui iimages
		private static var icon_dpad:Bitmap;
		private static var icon_dpad_frame:int = 0;
		private static var icon_pause:Bitmap;
		private static var icon_c:Bitmap;
		private static var icon_x:Bitmap;
		private static var icon_menu:Bitmap;
		private static var icon_x_frame:int = -1;
		private static var icon_c_frame:int = -1;
		private static var icon_menu_frame:int = -1;
		
		public var mobile_bg:Bitmap;
		public static var left_bar:Bitmap;
		public static var right_bar:Bitmap;
		
		
		[Embed(source = "res/sprites/mobile/button_c.png")] public static const embed_mobile_c:Class;
		[Embed(source = "res/sprites/mobile/button_x.png")] public static const embed_mobile_x:Class;
		[Embed(source = "res/sprites/mobile/button_menu.png")] public static const embed_mobile_pause:Class;
		[Embed(source = "res/sprites/mobile/button_dpad.png")] public static const  embed_mobile_dpad:Class;
		[Embed(source = "res/sprites/mobile/screenedge_left.png")] public static const embed_bar_left:Class;
		[Embed(source = "res/sprites/mobile/screenedge_right.png")] public static const  embed_bar_right:Class;
		
		// Holds entire bitmap data
		private static const dpad_data:Bitmap = new embed_mobile_dpad;
		private static const x_data:Bitmap = new embed_mobile_x;
		private static const c_data:Bitmap = new embed_mobile_c;
		private static const menu_data:Bitmap = new embed_mobile_pause;
		
		private var t_up:Number = 0;
		private var tm_up:Number = 0.05;
		
		public function Intra() {
			
            for (var i:int = 0; i < Registry.DOOR_INFO.length; i++) {
                Registry.DOOR_INFO[i] = new Array();
				
            }
			Registry.embed2saveXML();
            Registry.checkDoorInfo();
			Registry.sound_data = new SoundData();
			Common_Sprites.init();
			DH.init_dialogue_state();
			
			Registry.CUR_HEALTH = Registry.MAX_HEALTH = 6;
			//goto_nexus();
			
			
			//overworld_before_entrance();
			overworld_street_entrance();
			//overworld_sadbro();
			
			//goto_debug_room_0_0();
			//goto_debug_room_1_0();
			//debug_grass();
			//goto_debug_room_0_2();
			//goto_debug_room_2_2();
			//goto_debug_conveyer();
			//debug_dash_1();
			//debug_springs();
			//water_anim_test();
			
			
			//goto_crowd_rotator();
			
			//goto_crowd_entrance();
			//goto_crowd_key1();
			//goto_crowd_dog();
			//goto_crowd_d_person();
			//goto_crowd_before_fl_2();
			//goto_crowd_before_boss();
			//goto_crowd_boss();
			//goto_crowd_2nd_floor();
			//goto_cliff();
			//S_NPC.test();
			
			//goto_bedroom_problem_room();
			//goto_bedroom_key_1_room();
			//goto_bedroom_2_button_tl();
			//goto_bedroom_entrance();
			//goto_bedroom_boss();
			//goto_bedroom_shooty_room();

			//goto_beach_fisherman(); 
			
			goto_redsea_entrance();
			
			//goto_redcave_top_left();
			//goto_redcave();
			//goto_redcave_4way();
			//goto_redcave_river_room();
			//goto_redcave_lots_o_laserz();
			//goto_redcave_center_pillar_left();
			
			//goto_redcave_entrance();
			//goto_redcave_boss();
			
			//goto_street_walk();
			//goto_street_entrance();
			
			//goto_beach_entrance();
			
		    //apt_rat_puz();
			//apt_entrance();
			//apt_rm2();
			//apt_rat1();
			//apt_teleguy();
			
			//apt_boss();
			
			//hotel_dustmaid_test(); 	
			//hotel_fl3();
			//hotel_superdog();
			//hotel_steam_pipe();
			//hotel_burst_plants();
			//hotel_gas_river();
			//hotel_rooftop_entrance();
			//hotel_boss();
		
			//circus_before_javiera();
			//circus_dash_trap();
		    //circus_bounce_rollers();
			//circus_contort();
			//circus_lion();
			
			//drawer_north();
			//circus_entrance();
			//circus_before_arthur();
			//circus_slime_dog();
			//circus_boss();
			
			//cell_chaser_test();
			//suburb_walker_test();
			//space_face_test();
			
			//go_test();
			go_briar();
			//goto_windmill();
			//goto_windmill_top();
			//goto_blue();
			//goto_sage_fight();
			//goto_happy_event();
			//goto_happy_briar();
			//cliff_top_left_dog();
			
			//goto_fields_0_0();
			//goto_forest_briar();
			//goto_fields_mitra();
			//go("SPACE", 550, 400);
			//go("SPACE", 870, 570);
			//go("TERMINAL", 370, 730);
			//go("GO", 389, 131);
			go("GO", 390, 285);
			//go("GO", 390, 480);
			//go("FIELDS", 858, 192);
			//goto_blank_end();
			//go("TERMINAL", 375, 760);
			//go("BEACH", 530, 500); // near chest
			//go("DRAWER", 470, 740);
			//go("OVERWORLD", 232, 201);
			//go("FIELDS", 335, 650); // lonk's house
			//go("FIELDS", 690, 570); // Miao
			//go("NEXUS", 712, 464); // NEXUS SECRET
			//go("TRAIN", 110, 1300); // cell secret
			//go("DEBUG", 20, 340);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			//is_demo = true; // Lots of little flags of whether debug stuff works
			//is_release = true; // Prevents leaving FIELDS
			//is_mobile = true;
			
		    is_test = true; // Whether tutorial popups appear,
			allow_fuck_it_mode = true;
			//is_secret_press = true;
			
			//debug_mode();
			if (!is_demo) {
				Registry.autosave_on = false; // !!!!!!!
				did_init_fullscreening = true;
				debug_mode();
				Registry.SAVE_NAME = "ANODYNE_DEMO_SAVE_123";
			}
			var fil:Class = FillerTitleState as Class;	
			var ps:Class = make_play_or_roam_state();
			var active:Class;
			
			// Default values, may change with the Save.load() call
			Registry.GE_States[Registry.GE_MOBILE_IS_RHAND] = true;
			Registry.GE_States[Registry.GE_MOBILE_IS_XC] = true;
			
			if (is_demo) {
				Save.load(true); // So we don't the screen config if the dirty flag is "y"
				active = ps;
			} else {
				active = ps;
			}
			
			mobile_is_rhand = Registry.GE_States[Registry.GE_MOBILE_IS_RHAND];
			
			//NOTE THAT AUTOSAVING OVERWRITES STUFF WHEN TESTING 
			//Registry.FUCK_IT_MODE_ON = true;
			//super(160, 180, TitleState, 3);
			//super(160, 180, IntroScene, 3);
			//super(160, 180, EndingState, 3);
			
			if (is_mobile) {
				frame_x_px = frame_y_px = 0;
			}
			super(160, 180,  active, 3, 60,30);
			FlxG.volume = 1;
		}
		
		private function go(name:String, x:int, y:int):void {
			Registry.ENTRANCE_PLAYER_X = x;
			Registry.ENTRANCE_PLAYER_Y = y;
			Registry.CURRENT_MAP_NAME = name;
		}
		
		override protected function update():void 
		{
			
			t_up += FlxG.elapsed;
			if (t_up > tm_up && icon_x != null) {
				set_button_frame(0, true);
				set_button_frame(1, true);
				set_button_frame(2, true);
			}
			
			
			if (!is_mobile) {
				
				
				// Hitting "ESC" windows the screen. Make sre the game resizes accordingly 
				if (stage.displayState == "normal") { //windowed 
					if (scale_ctr != 1) {
						force_scale = true;
						scale_ctr = 0;
					}
					if (is_test) {
						for (var poop:int = 0; poop < Registry.Nexus_Door_State.length; poop++) {
							Registry.Nexus_Door_State[poop] = true;
						}	
						if (FlxG.keys.A) {
							y += 0.8;
						}
						if (FlxG.keys.S) {
							y = 0;
						}
					}
				} else if (scale_ctr == 0) { //strethced fullscreen
					x = full_scale_offset.x;
					y = full_scale_offset.y;
				} else if (scale_ctr == 2) { //int scaled FS
					x = full_scale_offset.x;
					y = full_scale_offset.y;
				}

			
				if (FlxG.keys.justPressed("TAB") || !did_init_fullscreening || force_scale) {
					force_scale = false;
					did_init_fullscreening = true;
					scale_ctr++;
					resize();
				}
			} else {
				if (!did_mobile_setup && stage != null) {
					did_mobile_setup = true;
					
					NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
					
					
					ratio = stage.stageHeight / 540;
					
					
					x = (stage.stageWidth - 480 * ratio) / 2;
					x /= ratio; //Yeah what the fuck right
					
					Preloader.display.scaleY = ratio;
					Preloader.display.scaleX = ratio;
					
					
					var extra:int = 0;
					
					var margin_w:int = (stage.stageWidth - int(480*ratio)) / 2 + extra;
					var margin_h:int = (stage.stageHeight);
					var big_off:int = (Intra.mobile_is_rhand) ? 0 : margin_w + ratio * 480 + 1;
					
					// up_sprite.alpha = 0;
					var y_split:Number = 7; // 1 / y_split = proportion of the hitbox's height
					var x_split:Number = 3; // .... width
					if (stage.width > 960) {
						x_split = 5;
						y_split = 11;
					}
					
					up_sprite = new Bitmap(new BitmapData(margin_w + extra, ((y_split - 1) / 2) * (margin_h / y_split), true, 0xff990000));
					down_sprite = new Bitmap(new BitmapData(margin_w + extra, ((y_split -1)/2)  * (margin_h / y_split), true, 0xff990000));
					left_sprite = new Bitmap(new BitmapData((margin_w / x_split) * ((x_split - 1)/2)  + extra, margin_h, true, 0xff009900));
					right_sprite = new Bitmap(new BitmapData((margin_w / x_split) * ((x_split - 1)/2) + extra, margin_h, true, 0xff009900));
					a1_sprite = new Bitmap(new BitmapData(margin_w / 2, 3 * (margin_h / 5),true, 0xffff0000));
					a2_sprite = new Bitmap(new BitmapData(margin_w / 2, 3 * (margin_h / 5), true,0xff00ff00));
					pause_sprite = new Bitmap(new BitmapData(margin_w, margin_h / 5, true, 0xff00ff00));
					mobile_bg = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xff06101b));
					
				
					
					icon_dpad = new Bitmap(new BitmapData(144, 144));
					icon_c = new Bitmap(new BitmapData(48, 96));
					icon_x = new Bitmap(new BitmapData(48, 96));
					icon_pause = new Bitmap(new BitmapData(96, 48));
					left_bar = new Bitmap(new BitmapData(4, stage.stageHeight));
					right_bar = new Bitmap(new BitmapData(4, stage.stageHeight));
					
					var left_bar_data:Bitmap  = new embed_bar_left;
					var right_bar_data:Bitmap = new embed_bar_right;
					
					var r:Rectangle = new Rectangle(0, 0, 4, 2);
					var p:Point = new Point(0, 0);
					
					while (p.y + 2 <= left_bar.height) {
						left_bar.bitmapData.copyPixels(left_bar_data.bitmapData,r,p)
						p.y += 2;
					}
					p.y = 0;
					while (p.y + 2 <= right_bar.height) {
						right_bar.bitmapData.copyPixels(right_bar_data.bitmapData, r, p);
						p.y += 2;
					}
					
					
					
					
					// These don't need to be added to check for logical overlaps!!
					/*stage.addChild(up_sprite);
					stage.addChild(down_sprite);
					stage.addChild(left_sprite);
					stage.addChild(right_sprite);
					stage.addChild(pause_sprite);*/
					
					// These are the graphics the player sees, but logically do nothing.
					stage.addChildAt(icon_c,0);
					stage.addChildAt(icon_pause,0);
					stage.addChildAt(icon_x,0);
					stage.addChildAt(icon_dpad, 0);
					stage.addChildAt(left_bar, 0);
					stage.addChildAt(right_bar, 0);
					stage.addChildAt(mobile_bg, 0);
					//stage.addChild(a1_sprite);
					//stage.addChild(a2_sprite);
					set_dpad_frame(4);
					set_button_frame(0);
					set_button_frame(1);
					set_button_frame(2);
					
					
					// Set hitboxes for UI interactions.
					left_sprite.x = up_sprite.x = down_sprite.x = big_off;
					right_sprite.x = big_off + (x_split -  ((x_split - 1) / 2)) * (margin_w / x_split);
					left_sprite.y = up_sprite.y = right_sprite.y = 0;
					down_sprite.y =  (y_split - (y_split - 1)/2)  * (margin_h / y_split);
					pause_sprite.x = stage.stageWidth - margin_w - big_off;
					pause_sprite.y = 4 * (margin_h / 5);

					a1_sprite.x = stage.stageWidth - margin_w / 2 - big_off;
					a1_sprite.y = 0;
					a2_sprite.x = stage.stageWidth - margin_w - big_off;
					a2_sprite.y = 0;
					
					// Add graphics in
					
					reposition_vert_bars();
					reposition_ui();
					
					if (!mobile_is_rhand) {
						mobile_flip_handedness();
					}
					
					if (!Registry.GE_States[Registry.GE_MOBILE_IS_XC]) {
						mobile_flip_x_c();
					}
					//stage.addEventListener(MouseEvent.MOUSE_MOVE, handle_touch_move);
					//stage.addEventListener(MouseEvent.CLICK, handle_mouse_click);
					//stage.addEventListener(MouseEvent.MOUSE_UP, handle_mouse_click);
					//stage.addEventListener(MouseEvent.MOUSE_DOWN, handle_mouse_click);
					
					stage.addEventListener(TouchEvent.TOUCH_MOVE, handle_touch_move);
					stage.addEventListener(TouchEvent.TOUCH_BEGIN, handle_mouse_click);
					stage.addEventListener(TouchEvent.TOUCH_END, handle_mouse_click);
					
					stage.addEventListener(Event.DEACTIVATE, handle_deactivate);
					stage.addEventListener(Event.ACTIVATE, handle_activate);
					
					
				}
				
				if (stage != null) {
					if (x != (stage.stageWidth - 480*ratio) / (2*ratio)) {
						x = (stage.stageWidth - 480*ratio) / (2*ratio);
					}
				}
			}
			super.update();
		}
		
		public function reposition_vert_bars():void {
			left_bar.x = int(pause_sprite.width) - 4;
			
			right_bar.x = stage.stageWidth - pause_sprite.width;
			//right_bar.x = Preloader.display.x + Preloader.display.width;
			
			
		}
		// Set frame of dpad
		public static function set_dpad_frame(frame:int):void {
			if (frame > 8 || frame == icon_dpad_frame) return;
			
			var w:int = icon_dpad.width;
			var h:int = icon_dpad.height;
			var xoff:int = icon_dpad.width * (frame % 3);
			var yoff:int = icon_dpad.height * int(frame / 3);
			
			var r:Rectangle = new Rectangle(xoff, yoff, w, h);
			var p:Point = new Point(0, 0);
			icon_dpad.bitmapData.copyPixels(dpad_data.bitmapData, r, p);
			icon_dpad_frame = frame;
			
			
			r = null;
			p = null;
		}
		
		/**
		 * 
		 * @param	id 0 for x, 1, for c, 2, for pause , , ,,  
		 * @param	UP true = up frame
		 */
		public static function set_button_frame(id:int, UP:Boolean=true):void {
			
			if (id == 0) {
				if (UP && icon_x_frame == 0) {
					return;
				} else if (!UP && icon_x_frame == 1) {
					return;
				}
			} else if (id == 1) {
				if (UP && icon_c_frame == 0) {
					return;
				} else if (!UP && icon_c_frame == 1) {
					return;
				}
			} else if (id == 2) {
				if (UP && icon_menu_frame == 0) {
					return;
				} else if (!UP && icon_menu_frame == 1) {
					return;
				}
			}
			
			var w:int; var h:int; var xoff:int; var yoff:int;
			var r:Rectangle;
			var p:Point = new Point(0, 0);
			xoff = 0;
			if (id == 0) {
				w = icon_x.width; h = icon_x.height;
				if (false == UP) xoff = w;
				r = new Rectangle(xoff, 0, w, h);
				icon_x.bitmapData.copyPixels(x_data.bitmapData, r, p);
				if (UP) {
					icon_x_frame = 0;
				} else {
					icon_x_frame = 1;
				}
			} else if (id == 1) {
				w = icon_c.width; h = icon_c.height;
				if (false == UP) xoff = w;
				r = new Rectangle(xoff, 0, w, h);
				icon_c.bitmapData.copyPixels(c_data.bitmapData, r, p);
				if (UP) {
					icon_c_frame = 0;
				} else {
					icon_c_frame = 1;
				}
			} else if (id == 2) {
				w = icon_pause.width; h = icon_pause.height;
				if (false == UP) xoff = w;
				r = new Rectangle(xoff, 0, w, h);
				icon_pause.bitmapData.copyPixels(menu_data.bitmapData, r, p);
				if (UP) {
					icon_menu_frame = 0;
				} else {
					icon_menu_frame= 1;
				}
			}
			
			r = null;
			p = null;
		}
		
		public function mobile_flip_handedness():void {
			Registry.GE_States[Registry.GE_MOBILE_IS_RHAND] = !Registry.GE_States[Registry.GE_MOBILE_IS_RHAND];
			Intra.mobile_is_rhand = Registry.GE_States[Registry.GE_MOBILE_IS_RHAND];
			var big_off:int = Math.max(up_sprite.x, Math.min(a2_sprite.x,a1_sprite.x));
			if (up_sprite.x > a1_sprite.x) {
				a1_sprite.x += big_off;
				a2_sprite.x += big_off;
				pause_sprite.x += big_off;
				left_sprite.x = up_sprite.x = down_sprite.x = 0;
				right_sprite.x -= big_off;
			} else {
				a1_sprite.x -= big_off;
				a2_sprite.x -= big_off;
				pause_sprite.x = 0;
				left_sprite.x = up_sprite.x = down_sprite.x = big_off;
				right_sprite.x += big_off;
			}
			reposition_ui();
		}
		public function mobile_flip_x_c():void {
			Registry.GE_States[Registry.GE_MOBILE_IS_XC] = !Registry.GE_States[Registry.GE_MOBILE_IS_XC];
			var old_x:int = a1_sprite.x;
			a1_sprite.x = a2_sprite.x;
			a2_sprite.x = old_x;
			// also flip The ICONS
			reposition_ui();
	
		}
		public function handle_deactivate(e:Event):void {
			SoundMixer.stopAll();
		}
		
		public function handle_activate(e:Event):void {
			if (Registry.sound_data != null && Registry.sound_data.current_song != null) {
				Registry.sound_data.current_song.play();
			}
		}
		
		public function maybe_update_action_gui(x:int,y:int):void {
			if (inside(x, y, a1_sprite)) {
				set_button_frame(1, false); // C!! FUCK
			} else {
				set_button_frame(1, true);
			}
			
			if (inside(x, y, a2_sprite)) {
				set_button_frame(0, false);
			} else {
				set_button_frame(0, true);
			}
			
			if (inside(x, y, pause_sprite)) {
				set_button_frame(2, false);
			} else {
				set_button_frame(2, true);
			}
		}
		public function handle_touch_move(e:*):void {
			var x:int = e.stageX;
			var y:int = e.stageY;
			
			
			// makesure touching other side deosnt stop movmenet
			if (x > stage.stageWidth / 2 && Intra.mobile_is_rhand) {
				maybe_update_action_gui(x, y);
				t_up = 0;
				return; // Touching right side
			}
			
			if (x < stage.stageWidth / 2 && !Intra.mobile_is_rhand) {
				maybe_update_action_gui(x, y);
				t_up = 0;
				return; // Movement on right side, blah
			}
			
			var flags:uint = 0x0;
			if (inside(x, y, up_sprite)) {
				flags |= 8; // U
				Keys.FORCE_UP = true;
				Keys.FORCE_DOWN = false;
			}  else if (inside(x, y, down_sprite)) {
				Keys.FORCE_UP = false;
				flags |= 2; // D
				Keys.FORCE_DOWN = true;
			} else {
				Keys.FORCE_DOWN = Keys.FORCE_UP = false;
			}
			
			if (inside(x, y, left_sprite)) {
				flags |= 1; // L
				Keys.FORCE_LEFT = true;
				Keys.FORCE_RIGHT = false;
			} else if  (inside(x, y, right_sprite)) {
				flags |= 4; // R
				Keys.FORCE_RIGHT = true;
				Keys.FORCE_LEFT = false;
			} else {
				Keys.FORCE_RIGHT = Keys.FORCE_LEFT = false;
			}
			
			// i guess this could be more straightforward if we change the image.
			switch (flags) {
				case 0: // none
					set_dpad_frame(4);
					break;
				case 1: 
					set_dpad_frame(3);
					break;
				case 2:
					set_dpad_frame(7);
					break;
				case 3:
					set_dpad_frame(6);
					break;
				case 4:
					set_dpad_frame(5);
					break;
				case 12:
					set_dpad_frame(2);
					break;
				case 6:
					set_dpad_frame(8);
					break;
				case 9:
					set_dpad_frame(0);
					break;
				case 8:
					set_dpad_frame(1);
					break;
			}
			
		}
		
		// son of af ucking btich FUCK
		private function inside(x:int, y:int, s:*):Boolean {
			
			if (x >= s.getRect(stage).x  && x <= (s.getRect(stage).x + s.width) && y >= s.getRect(stage).y && y <= (s.getRect(stage).y + s.height)) {
				return true;
			}
			return false;
		}
		public function handle_mouse_click(e:*):void {
			if (Registry.keywatch == null) return;
			if (e.type == TouchEvent.TOUCH_END) {
				
				if (inside(e.stageX, e.stageY, left_sprite)) {
					Keys.FORCE_LEFT = false;
					
				} else if (inside(e.stageX, e.stageY, right_sprite)) {
					Keys.FORCE_RIGHT = false;
				} 
				if (inside(e.stageX, e.stageY, up_sprite)) {
					Keys.FORCE_UP = false;
				} else if (inside(e.stageX, e.stageY, down_sprite)) {
					Keys.FORCE_DOWN= false;
				} 
			
				
				return;
			}
			
			// touch tap
		
			if (inside(e.stageX, e.stageY, left_sprite)) {
				Registry.keywatch.SIG_JP_LEFT = true;
			} else if (inside(e.stageX, e.stageY, right_sprite)) {
				Registry.keywatch.SIG_JP_RIGHT = true;
			} 
			
			if (inside(e.stageX, e.stageY, up_sprite)) {
				Registry.keywatch.SIG_JP_UP = true;
			} else if (inside(e.stageX, e.stageY, down_sprite)) {
				Registry.keywatch.SIG_JP_DOWN = true;
			} 
			
			if (inside(e.stageX, e.stageY, a1_sprite)) {
				Keys.FORCE_ACTION_1 = true;
			} else if (inside(e.stageX, e.stageY, a2_sprite)) {
				Keys.FORCE_ACTION_2 = true;
			} else if (inside(e.stageX, e.stageY, pause_sprite)) {
				Registry.keywatch.JUST_PRESSED_PAUSE = true;
			}
			
			
		}
		
	
		public function resize():void {
			var ratio:Number;
			var ssp:int;
			
			if (NativeApplication.nativeApplication.activeWindow == null) return;
			
			if (!did_init_window_fix) {
				did_init_window_fix = true;
				NativeApplication.nativeApplication.activeWindow.width += frame_x_px;
				NativeApplication.nativeApplication.activeWindow.height += frame_y_px;
			}
			
			if (scale_factor <= 0) {
				scale_factor = 3;
			}
			switch (scale_ctr) {
				case 1: //Windowed
					
					ratio = scale_factor / 3;
					stage.displayState = StageDisplayState.NORMAL;
					NativeApplication.nativeApplication.activeWindow.width = int(480 * ratio) + frame_x_px;
					NativeApplication.nativeApplication.activeWindow.height = int(540 * ratio) + frame_y_px;
					Preloader.display.scaleX = ratio;
					Preloader.display.scaleY = ratio;
					x = y = 0;
					
					break;
				case 2: // Fullscreen integer scaling
					ratio = scale_factor / 3;
					// Don't scale past the size of screen
					stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					Preloader.display.scaleX = ratio;
					Preloader.display.scaleY = ratio;
					ssp = (stage.fullScreenWidth - (480 * ratio)) / 2;
					x = ssp / ratio;
					ssp = (stage.fullScreenHeight - (540 * ratio)) / 2;
					y = ssp / ratio;
					full_scale_offset.x = x;
					full_scale_offset.y = y;
					
					break;
				case 3: // Stretched proportionaly (full screen)
					stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					if (stage.fullScreenHeight > stage.fullScreenWidth) {
						ratio = stage.fullScreenWidth / 480;
						ssp = (stage.fullScreenHeight - (540 * ratio)) / 2;
						x = 0;
						y = ssp / ratio;
						is_landscape = false;
					} else {
						ratio = stage.fullScreenHeight / 540;
						ssp = (stage.fullScreenWidth - (480 * ratio)) / 2; //Screen-space pixels to move to the right
						x = ssp / ratio; // In stage-space, only move by enough pixels that will make everything look okay when it's scaled to screen space
						y = 0;
						is_landscape = true;
					}
					Preloader.display.scaleX =  Preloader.display.scaleY = ratio; // For some reason this scale value gets set or something if I do it earlier. oh well!
					full_scale_offset.x = x;
					full_scale_offset.y = y;
					scale_ctr = 0;
					break;
			}
		}
		public function debug_mode():void {
			Registry.inventory[0] = true; //broom
			//Registry.inventory[1] = true; // jump
			Registry.inventory[2] = true; //transfomrer
			Registry.inventory[4] = true; //widen
			Registry.inventory[5] = true; //lengthe
			Registry.inventory[6] = true;
			Registry.inventory[7] = true;
			Registry.inventory[8] = true;
			Registry.bound_item_1 = "BROOM";
			Registry.bound_item_2 = "JUMP";
			Registry.CUR_HEALTH =12;
			Registry.MAX_HEALTH = 12;
		}
		
		
		public function drawer_north():void {
			Registry.CURRENT_MAP_NAME = "DRAWER";
			Registry.ENTRANCE_PLAYER_X = 40;
			Registry.ENTRANCE_PLAYER_Y = 100;
		}
		public function go_briar():void {
			Registry.ENTRANCE_PLAYER_X = 386;
			Registry.ENTRANCE_PLAYER_Y = 280;
			Registry.CURRENT_MAP_NAME = "GO";
		}
		public function cliff_top_left_dog():void {
			Registry.ENTRANCE_PLAYER_X = 154;
			Registry.ENTRANCE_PLAYER_Y = 219;
			Registry.CURRENT_MAP_NAME = "CLIFF";
		}
		public function goto_fields_mitra():void {
			Registry.ENTRANCE_PLAYER_X = 690;
			Registry.ENTRANCE_PLAYER_Y = 600;
			Registry.CURRENT_MAP_NAME = "FIELDS";
		}
		
		public function goto_forest_briar():void {
			Registry.ENTRANCE_PLAYER_X = 500;
			Registry.ENTRANCE_PLAYER_Y = 350;
			Registry.CURRENT_MAP_NAME = "FOREST";
		}
		public function goto_happy_briar():void {
			Registry.ENTRANCE_PLAYER_X = 750;
			Registry.ENTRANCE_PLAYER_Y = 200;
			Registry.CURRENT_MAP_NAME = "HAPPY";
		}
		public function goto_windmill_top():void {
			Registry.ENTRANCE_PLAYER_X = 212;
			Registry.ENTRANCE_PLAYER_Y = 430;
			Registry.CURRENT_MAP_NAME = "WINDMILL";
		}
		
		public function goto_cliff	():void {
			Registry.ENTRANCE_PLAYER_X = 420;
			Registry.ENTRANCE_PLAYER_Y = 220;
			Registry.CURRENT_MAP_NAME = "CLIFF";
		}
		
		public function goto_happy_event():void {
			Registry.ENTRANCE_PLAYER_X = 301;
			Registry.ENTRANCE_PLAYER_Y = 390;
			Registry.CURRENT_MAP_NAME = "HAPPY";
		}
		
		public function goto_sage_fight():void {
			Registry.ENTRANCE_PLAYER_X = 61;
			Registry.ENTRANCE_PLAYER_Y = 327;
			Registry.CURRENT_MAP_NAME = "TERMINAL";
		}
		public function goto_blue():void {
			
			Registry.ENTRANCE_PLAYER_Y = 128;
			Registry.ENTRANCE_PLAYER_X = 5;
			Registry.CURRENT_MAP_NAME = "BLUE";
		}
		public function go_test():void {
			Registry.ENTRANCE_PLAYER_Y = 0;
			Registry.ENTRANCE_PLAYER_X = 70;
			Registry.CURRENT_MAP_NAME = "GO";
		}
		public function water_anim_test():void {
			Registry.ENTRANCE_PLAYER_Y = 38;
			Registry.ENTRANCE_PLAYER_X = 686;
			Registry.CURRENT_MAP_NAME = "DEBUG";
		}
		
		public function space_face_test():void {
			Registry.ENTRANCE_PLAYER_X = 70;
			Registry.ENTRANCE_PLAYER_Y = 70;
			Registry.CURRENT_MAP_NAME = "SPACE";
		}
		public function suburb_walker_test():void {
			Registry.ENTRANCE_PLAYER_X = 70;
			Registry.ENTRANCE_PLAYER_Y = 70;
			Registry.CURRENT_MAP_NAME = "SUBURB";
		}
		
		public function cell_chaser_test():void {
			Registry.ENTRANCE_PLAYER_X = 252;
			Registry.ENTRANCE_PLAYER_Y = 262;
			Registry.CURRENT_MAP_NAME = "TRAIN";
		}
		
		public function  overworld_sadbro():void {
			Registry.ENTRANCE_PLAYER_X = 715 + 160;
			Registry.ENTRANCE_PLAYER_Y = 1317 - 160;
			Registry.CURRENT_MAP_NAME = "OVERWORLD";
		}
		
		public function overworld_before_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 715;
			Registry.ENTRANCE_PLAYER_Y = 1317;
			Registry.CURRENT_MAP_NAME = "OVERWORLD";
		}
		public function overworld_street_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 715 - 320;
			Registry.ENTRANCE_PLAYER_Y = 1317;
			Registry.CURRENT_MAP_NAME = "OVERWORLD";
		}
		public function circus_boss():void {
			Registry.ENTRANCE_PLAYER_X = 707;
			Registry.ENTRANCE_PLAYER_Y = 308;
			Registry.CURRENT_MAP_NAME = "CIRCUS";
		}
		
		public function debug_springs():void {
			Registry.ENTRANCE_PLAYER_X = 560;
			Registry.ENTRANCE_PLAYER_Y = 190;
			Registry.CURRENT_MAP_NAME = "DEBUG";
			
		}
		public function circus_contort():void {
			Registry.ENTRANCE_PLAYER_X = 512;
			Registry.ENTRANCE_PLAYER_Y = 528;
			Registry.CURRENT_MAP_NAME = "CIRCUS";
		}
		
		
		public function circus_before_javiera():void {
			Registry.ENTRANCE_PLAYER_X = 1250;
			Registry.ENTRANCE_PLAYER_Y = 550
			Registry.CURRENT_MAP_NAME = "CIRCUS";
		}
		
		public function circus_slime_dog():void {
			Registry.ENTRANCE_PLAYER_X = 286;
			Registry.ENTRANCE_PLAYER_Y = 922;
			Registry.CURRENT_MAP_NAME = "CIRCUS";
			 
		}
		
		public function circus_before_arthur():void {
			Registry.ENTRANCE_PLAYER_X = 1410;
			Registry.ENTRANCE_PLAYER_Y = 1040;
			Registry.CURRENT_MAP_NAME = "CIRCUS";
		}
		
		public function circus_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 710;
			Registry.ENTRANCE_PLAYER_Y = 1400;
			Registry.CURRENT_MAP_NAME = "CIRCUS";
		}
		
		public function circus_lion():void {
			Registry.ENTRANCE_PLAYER_X = 680;
			Registry.ENTRANCE_PLAYER_Y = 860;
			Registry.CURRENT_MAP_NAME = "CIRCUS";
		}
		
		public function circus_bounce_rollers():void {
			Registry.ENTRANCE_PLAYER_X = 990;
			Registry.ENTRANCE_PLAYER_Y = 610;
			Registry.CURRENT_MAP_NAME = "CIRCUS";
		}
		
		public function circus_dash_trap():void {
			Registry.ENTRANCE_PLAYER_X = 1000;
			Registry.ENTRANCE_PLAYER_Y = 1140;
			Registry.CURRENT_MAP_NAME = "CIRCUS";
		}
		public function debug_dash_1():void {
			Registry.ENTRANCE_PLAYER_X = 351;
			Registry.ENTRANCE_PLAYER_Y = 128;
			Registry.CURRENT_MAP_NAME = "DEBUG";
			
		}
		public function hotel_boss():void {
			Registry.ENTRANCE_PLAYER_X = 1350;
			Registry.ENTRANCE_PLAYER_Y = 1450;
			Registry.CURRENT_MAP_NAME = "HOTEL";
		}
		
		public function hotel_rooftop_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 257;
			Registry.ENTRANCE_PLAYER_Y = 257;
			Registry.CURRENT_MAP_NAME = "HOTEL";
			Registry.E_PLAY_ROOF = true;
		}
		public function hotel_gas_river():void {
			Registry.ENTRANCE_PLAYER_X = 1400;
			Registry.ENTRANCE_PLAYER_Y = 1060;
			Registry.CURRENT_MAP_NAME = "HOTEL";
		}
		public function hotel_burst_plants():void {
			Registry.ENTRANCE_PLAYER_X = 1003;
			Registry.ENTRANCE_PLAYER_Y = 34 + 160*3;
			Registry.CURRENT_MAP_NAME = "HOTEL";
		}
		public function hotel_steam_pipe():void {
			Registry.ENTRANCE_PLAYER_X = 1093;
			Registry.ENTRANCE_PLAYER_Y = 50;
			Registry.CURRENT_MAP_NAME = "HOTEL";
		}
		public function hotel_fl3():void {
			Registry.ENTRANCE_PLAYER_X = 403;
			Registry.ENTRANCE_PLAYER_Y = 1874;
			Registry.CURRENT_MAP_NAME = "HOTEL";
		}
		public function hotel_superdog():void {
			Registry.ENTRANCE_PLAYER_X = 724;
			Registry.ENTRANCE_PLAYER_Y = 741;
			Registry.CURRENT_MAP_NAME = "HOTEL";
		}
		public function apt_rat_puz():void {
			Registry.ENTRANCE_PLAYER_X = 1139;
			Registry.ENTRANCE_PLAYER_Y = 18;
			Registry.CURRENT_MAP_NAME = "APARTMENT";
		}
		public function apt_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 393;
			Registry.ENTRANCE_PLAYER_Y = 920;
			Registry.CURRENT_MAP_NAME = "APARTMENT";
		}
		public function debug_grass():void {
			Registry.ENTRANCE_PLAYER_X = 320 + 60;
			Registry.ENTRANCE_PLAYER_Y = 160 + 70;
			Registry.CURRENT_MAP_NAME = "DEBUG";
		}
		public function apt_boss():void {
			Registry.ENTRANCE_PLAYER_X = 1195;
			Registry.ENTRANCE_PLAYER_Y = 1060;
			Registry.CURRENT_MAP_NAME = "APARTMENT";
		}
		public function apt_rat1():void  {
			Registry.ENTRANCE_PLAYER_X = 528;
			Registry.ENTRANCE_PLAYER_Y = 288;
			Registry.CURRENT_MAP_NAME = "APARTMENT";
		}
			
		public function apt_rm2():void {
			Registry.ENTRANCE_PLAYER_X = 400;
			Registry.ENTRANCE_PLAYER_Y = 722;
			Registry.CURRENT_MAP_NAME = "APARTMENT";
		}
			
		public function apt_teleguy():void {
			Registry.ENTRANCE_PLAYER_X = 214;
			Registry.ENTRANCE_PLAYER_Y = 675;
			Registry.CURRENT_MAP_NAME = "APARTMENT";
		}
		
		
		public function goto_blank_end():void {
			Registry.ENTRANCE_PLAYER_X = 397 - 320;
			Registry.ENTRANCE_PLAYER_Y = 107;
			Registry.CURRENT_MAP_NAME = "BLANK";
			
		}
		
		public function goto_fields_0_0():void {
			Registry.ENTRANCE_PLAYER_X = 20;
			Registry.ENTRANCE_PLAYER_Y = 28;
			Registry.CURRENT_MAP_NAME = "FIELDS";
		}
		public function goto_nexus():void {
			Registry.ENTRANCE_PLAYER_X = 776;
			Registry.ENTRANCE_PLAYER_Y = 1372;
			Registry.CURRENT_MAP_NAME = "NEXUS";
		}
		public function goto_redcave():void {
			Registry.ENTRANCE_PLAYER_X = 785;
			Registry.ENTRANCE_PLAYER_Y = 273;
			Registry.CURRENT_MAP_NAME = "REDCAVE";
		}
		public function goto_redcave_boss():void {
			Registry.ENTRANCE_PLAYER_X = 976;
			Registry.ENTRANCE_PLAYER_Y = 20 + 140;
			Registry.CURRENT_MAP_NAME = "REDCAVE";
		}
		public function goto_redcave_4way():void {
			Registry.ENTRANCE_PLAYER_X = 556 - 160;
			Registry.ENTRANCE_PLAYER_Y = 890 - 320;
			Registry.CURRENT_MAP_NAME = "REDCAVE";
		}
		public function goto_redcave_river_room():void {
			Registry.ENTRANCE_PLAYER_X = 100;
			Registry.ENTRANCE_PLAYER_Y = 600;
			Registry.CURRENT_MAP_NAME = "REDCAVE";
		}
		public function goto_redcave_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 550;
			Registry.ENTRANCE_PLAYER_Y = 770;
			Registry.CURRENT_MAP_NAME = "REDCAVE";
		}
		public function goto_redcave_center_pillar_left():void {
			Registry.ENTRANCE_PLAYER_X = 200;
			Registry.ENTRANCE_PLAYER_Y = 260;
			Registry.CURRENT_MAP_NAME = "REDCAVE";
		}
		public function goto_redcave_lots_o_laserz():void {
			Registry.ENTRANCE_PLAYER_X = 39;
			Registry.ENTRANCE_PLAYER_Y = 821;
			Registry.CURRENT_MAP_NAME = "REDCAVE";
		}
		public function goto_redcave_top_left():void {
			Registry.ENTRANCE_PLAYER_X = 55;
			Registry.ENTRANCE_PLAYER_Y = 21;
			Registry.CURRENT_MAP_NAME = "REDCAVE";
		}
		
		public function goto_debug_room_0_0():void {
			Registry.ENTRANCE_PLAYER_X = 36;
			Registry.ENTRANCE_PLAYER_Y = 132;
			Registry.CURRENT_MAP_NAME = "DEBUG";
			
		}
		public function goto_debug_room_1_0():void {
			Registry.ENTRANCE_PLAYER_X = 176;
			Registry.ENTRANCE_PLAYER_Y = 116;
			Registry.CURRENT_MAP_NAME = "DEBUG";
			
		}
		
		public function goto_debug_room_0_2():void {
			Registry.ENTRANCE_PLAYER_X = 60;
			Registry.ENTRANCE_PLAYER_Y = 349;
			Registry.CURRENT_MAP_NAME = "DEBUG";
		}
		
		
		public function goto_debug_room_2_2():void {
			Registry.ENTRANCE_PLAYER_X = 395;
			Registry.ENTRANCE_PLAYER_Y = 404;
			Registry.CURRENT_MAP_NAME = "DEBUG";
		}
		public function goto_debug_conveyer():void {
			Registry.ENTRANCE_PLAYER_X = 176;
			Registry.ENTRANCE_PLAYER_Y = 116 + 160;
			Registry.CURRENT_MAP_NAME = "DEBUG";
			
		}
		public function goto_bedroom_key_1_room():void {
			Registry.ENTRANCE_PLAYER_X = 130;
			Registry.ENTRANCE_PLAYER_Y = 720;
			Registry.CURRENT_MAP_NAME = "BEDROOM";
		}
		
		public function goto_bedroom_problem_room():void {
			Registry.ENTRANCE_PLAYER_X = 390;
			Registry.ENTRANCE_PLAYER_Y = 120+320;
			Registry.CURRENT_MAP_NAME = "BEDROOM";
		}
		public function goto_bedroom_shooty_room():void {
			Registry.ENTRANCE_PLAYER_X = 58 + 320;
			Registry.ENTRANCE_PLAYER_Y = 720 - 480;
			Registry.CURRENT_MAP_NAME = "BEDROOM";
		}
		
		
		public function goto_bedroom_2_button_tl():void {
			Registry.ENTRANCE_PLAYER_X = 58;
			Registry.ENTRANCE_PLAYER_Y = 720 - 480;
			Registry.CURRENT_MAP_NAME = "BEDROOM";
		}
		
		public function goto_bedroom_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 400;
			Registry.ENTRANCE_PLAYER_Y = 760;
			Registry.CURRENT_MAP_NAME = "BEDROOM";
		}
		
		public function goto_bedroom_boss():void {
			Registry.ENTRANCE_PLAYER_X = 390 + 160;
			Registry.ENTRANCE_PLAYER_Y = 120;
			Registry.CURRENT_MAP_NAME = "BEDROOM";
		}
		
		public function goto_street_walk():void {
			Registry.ENTRANCE_PLAYER_X = 267;
			Registry.ENTRANCE_PLAYER_Y = 290 + 160;
			Registry.CURRENT_MAP_NAME = "STREET";
		}
		
		public function goto_street_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 267;
			Registry.ENTRANCE_PLAYER_Y = 290 + 640;
			Registry.CURRENT_MAP_NAME = "STREET";
			
		}
		
		public function goto_beach_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 724;
			Registry.ENTRANCE_PLAYER_Y = 263;
			Registry.CURRENT_MAP_NAME = "BEACH";
		}
		
		public function goto_beach_fisherman():void {
			Registry.ENTRANCE_PLAYER_X = 595;
			Registry.ENTRANCE_PLAYER_Y = 165;
			Registry.CURRENT_MAP_NAME = "BEACH";
		}
		public function goto_redsea_entrance():void {
			
			Registry.ENTRANCE_PLAYER_X = 241;
			Registry.ENTRANCE_PLAYER_Y = 41;
			Registry.CURRENT_MAP_NAME = "REDSEA";
		}
		
		
		public function goto_crowd_rotator():void {
			Registry.ENTRANCE_PLAYER_X = 227;
			Registry.ENTRANCE_PLAYER_Y = 1090;
			Registry.CURRENT_MAP_NAME = "CROWD";
			
		}
		
		public function goto_crowd_before_boss():void {
			
			Registry.ENTRANCE_PLAYER_X = 1500;
			Registry.ENTRANCE_PLAYER_Y = 360;
			Registry.CURRENT_MAP_NAME = "CROWD";
		}
		public function goto_crowd_before_fl_2():void {
			Registry.ENTRANCE_PLAYER_X = 560;
			Registry.ENTRANCE_PLAYER_Y = 510;
			Registry.CURRENT_MAP_NAME = "CROWD";
			
		}
		public function goto_crowd_entrance():void {
			Registry.ENTRANCE_PLAYER_X = 547;
			Registry.ENTRANCE_PLAYER_Y = 1240;
			Registry.CURRENT_MAP_NAME = "CROWD";
		}
		public function goto_crowd_key1():void {
			Registry.ENTRANCE_PLAYER_X = 408;
			Registry.ENTRANCE_PLAYER_Y = 604;
			Registry.CURRENT_MAP_NAME = "CROWD";
		}
		public function goto_crowd_dog():void {
			Registry.ENTRANCE_PLAYER_X = 564;
			Registry.ENTRANCE_PLAYER_Y = 895;
			Registry.CURRENT_MAP_NAME = "CROWD";
		}
		public function goto_crowd_d_person():void {
			Registry.ENTRANCE_PLAYER_X = 89;
			Registry.ENTRANCE_PLAYER_Y = 1082;
			Registry.CURRENT_MAP_NAME = "CROWD";
		}
		public function goto_crowd_2nd_floor():void {
			Registry.ENTRANCE_PLAYER_X = 1185;
			Registry.ENTRANCE_PLAYER_Y = 448;
			Registry.CURRENT_MAP_NAME = "CROWD";
		}
		
		public function goto_crowd_boss():void {
			Registry.ENTRANCE_PLAYER_X = 1520;
			Registry.ENTRANCE_PLAYER_Y = 1123;
			Registry.CURRENT_MAP_NAME = "CROWD";
		}
		
		public function hotel_dustmaid_test():void {
			Registry.ENTRANCE_PLAYER_X = 224;
			Registry.ENTRANCE_PLAYER_Y = 609;
			Registry.CURRENT_MAP_NAME = "HOTEL";
		}
		
		public function goto_windmill():void {
			Registry.ENTRANCE_PLAYER_X = 224;
			Registry.ENTRANCE_PLAYER_Y = 1248;
			Registry.CURRENT_MAP_NAME = "WINDMILL";
		}
		
		
		
		private static function make_play_or_roam_state():Class
		{
			Registry.set_is_playstate(Registry.CURRENT_MAP_NAME);
			var state:Class;
			if (Registry.is_playstate) {
				state = PlayState as Class;
			} else {
				state = RoamState as Class;
			}
			return state;
		}
		
		private function reposition_ui():void 
		{
			var dead_space_l:int = left_sprite.x + left_sprite.width;
			var dead_space_w:int = right_sprite.x - (left_sprite.x + left_sprite.width);
			var dead_space_h:int = down_sprite.y - (up_sprite.y + up_sprite.height);
			var dead_space_top:int = up_sprite.y + up_sprite.height;
			
			// Center the circle icon in the dead spot.
			/*if (dead_space_w - icon_dpad.width < 0) {
				icon_dpad.x = dead_space_l;
			} else {
				icon_dpad.x = dead_space_l + (dead_space_w - icon_dpad.width) / 2;
			}*/
			icon_dpad.x = dead_space_l + (dead_space_w - icon_dpad.width) / 2;
			icon_dpad.y = (stage.stageHeight - 144 ) / 2; 
			
			/*if (dead_space_h - icon_dpad.height < 0) {
				icon_dpad.y = dead_space_top;
			} else {
				icon_dpad.y = dead_space_top + (dead_space_h - icon_dpad.height) / 2;
			}*/
			
			// Stick directions around it
			
			
			icon_x.y = a2_sprite.y + (a2_sprite.height - icon_x.height);
			icon_c.y = a2_sprite.y + (a2_sprite.height - icon_x.height);
			if (Registry.GE_States[Registry.GE_MOBILE_IS_XC]) {
				icon_x.x = a2_sprite.x + a2_sprite.width - icon_x.width - 15;
				icon_c.x = a1_sprite.x + 15;
			} else {
				icon_x.x = a2_sprite.x + 15;
				icon_c.x = a1_sprite.x + a1_sprite.width - icon_c.width - 15;
			}
			
			
			icon_pause.x = pause_sprite.x + (pause_sprite.width - icon_pause.width) / 2;
			icon_pause.y = pause_sprite.y + (pause_sprite.height - icon_pause.height) / 2;
		}
	}
}
