package com 
{
	import flash.display.GraphicsPathWinding;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.flixel.*
	import com.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../../media/AvatarWhite.png')] private var AvSheet:Class;
		
		public static var lyrSprites:FlxLayer;		
		private var _move_speed:int = 400;
		private var _move_distance: int = 4;
		private const radius:Number = 70;
		
		private var _energy:Number;
		private const MAX_ENERGY:Number = 30;
		
		private const FOOD_COST:Number = 5;
		
		private var _colour_image: Class;
		
		public var _player_colour:int;
		
		private var _spriteSides: SpriteSides;
		private var _potential_x: int;
		private var _potential_y: int;
		private var changer:int=0;
		
		public function Player(X:int, Y:int):void
		{
			super(X, Y);
			_energy = 0;
			//set sprite sides
			_spriteSides = new SpriteSides(X, X + 94, Y, Y + 94);
			
			//_colour_image = ImgPlayerYellow;
			_player_colour = Colour.YELLOW;
			//loadGraphic(_colour_image, false, false, 66, 66);
			offset.x = 33;
			offset.y = 33;
			lyrSprites = new FlxLayer;
			scale.x = scale.y = 0.8;
			
			loadGraphic(AvSheet, true, false, 96, 96); 
			addAnimation("normal", [0]);
			addAnimation("down", [4]);//d l r u
			addAnimation("left", [5]);
			addAnimation("right", [6]);
			addAnimation("up", [7]);
		}
		
		public function addFood():Boolean
		{
			if (_energy >= FOOD_COST)
			{
				_energy -= FOOD_COST;
				return true;
			}
			return false;
		}
		
		private function increaseEnergy():void
		{
			if (_energy + FlxG.elapsed < MAX_ENERGY)
			{
				_energy += FlxG.elapsed *4;
			}
			
		}
		override public function update():void
		{
			play("normal");
			//Moving
			for each(var b:Bacteria in com.GameState._bacteria)
			{
				if (b.distanceFrom(this) < radius && b.color!=this._player_colour)
				{
					b.addBehaviour(RepelBehaviour, this, 200, 150);
				}
				else
				{
					if (b.removeBehaviour(RepelBehaviour))
					{
						b.removeAllBehaviours();
						b.addBehaviour(MoveToSinkBehaviour, GameState.testSink);
					}
				}
			}
			if (FlxG.keys.RIGHT)
			{
				var _prev_right_x: int = x;
				x = SinkBoundaries.getRightMovement(x, y, _spriteSides.RIGHT, _move_distance);
				if (x == _prev_right_x) {
					y = SinkBoundaries.slideOnYAxisInstead(x, y);
				}
				play("right");
			}
			
			if (FlxG.keys.LEFT)
			{
				var _prev_left_x: int = x;
				x = SinkBoundaries.getLeftMovement(x, y, _spriteSides.LEFT, _move_distance);
				if (x == _prev_left_x) {
					y = SinkBoundaries.slideOnYAxisInstead(x, y);
				}
				play("left");
			}
			
			if (FlxG.keys.UP)
			{
				var _prev_up_y: int = y;
				y = SinkBoundaries.getUpMovement(x, y, _spriteSides.TOP, _move_distance);
				if (y == _prev_up_y) {
					x = SinkBoundaries.slideOnXAxisInstead(x, y);
				}
				play("up");
			}
			
			if (FlxG.keys.DOWN)
			{
				var _prev_down_y: int = y;
				y = SinkBoundaries.getDownMovement(x, y, _spriteSides.BOTTOM, _move_distance);
				if (y == _prev_down_y) {
					x = SinkBoundaries.slideOnXAxisInstead(x, y);
				}
				play("down");
			}
			
			if (FlxG.keys.justPressed("CONTROL"))
			{
				changer++;
			}
			
			
			//Colour changing
			switch(changer%4+1)
			{
				case 1:
				//_colour_image = ImgPlayerYellow;
				_player_colour = Colour.YELLOW;
				color = Colour.YELLOW;
				//loadGraphic(_colour_image, false, false, 66, 66);
				break;
			
				case 2:
				_player_colour = Colour.RED;
				color = Colour.RED;
				break;
				
				case 3:
				_player_colour = Colour.GREEN;
				color = Colour.GREEN;
				break;
			
				case 4:
				_player_colour = Colour.BLUE;
				color = Colour.BLUE;
				break;
			}
			super.update();			
		}
	}
}

