package com 
{
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author D.Hutchison
	 * 
	 * A behaviour that puts a bacteria on a course towards a point with a jittery movement
	 */
	public class MoveToPointBehaviour extends Behaviour
	{
		private var _destination : Point;
		private var _direction : Point;
		private var _speed : Number;
		
		private const THRESHOLD:Number = 5;
		
		public function MoveToPointBehaviour(HostSprite:FlxSprite,Destination:Point,Speed:Number):void 
		{
			_destination = Destination;
			_speed = Speed;
			_direction = new Point(0, 0);
			
			super(HostSprite);
			
			_direction.x = _hostSprite.x - _destination.x;
			_direction.y = _hostSprite.y - _destination.y;
			var distance:Number = Math.sqrt(Math.pow(_direction.x, 2) + Math.pow(_direction.y, 2)); 
			
			_direction.x /= distance;
			_direction.y /= distance;
		}
		
		
		override public function update():void
		{
			_hostSprite.x -= _direction.x * FlxG.elapsed * _speed;
			_hostSprite.y -= _direction.y * FlxG.elapsed * _speed;
			
			if (_hostSprite.x <= _destination.x + THRESHOLD 
			&& _hostSprite.x >= _destination.x - THRESHOLD 
			&& _hostSprite.y <= _destination.y + THRESHOLD 
			&& _hostSprite.y >= _destination.y - THRESHOLD )
			{
				_finished = true;				
			}			
		}
	}

}