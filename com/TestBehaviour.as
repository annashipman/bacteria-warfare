package com 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/*
	 * A test behaviour
	 * 
	 * */
	
		
	public class TestBehaviour extends Behaviour
	{
		protected var _player :FlxSprite;
		protected var _speed :Number;
		protected var _min_distance:Number;
		
		public function TestBehaviour(HostSprite : FlxSprite, player : FlxSprite, Speed : Number, MinDistance : Number):void 
		{
			_player = player;
			_speed = Speed;
			_min_distance = MinDistance;
			super(HostSprite);
		}
		
		override public function update():void
		{
			var xcomp:Number = _hostSprite.x - _player.x
			var ycomp:Number = _hostSprite.y - _player.y
			
			var distance:Number = Math.sqrt(Math.pow(xcomp, 2) + Math.pow(ycomp, 2)); 
			
			
			if (_hostSprite.color != _player.color)
			{
				if (distance < _min_distance)
				//if it gets too close
				{
					_hostSprite.x += xcomp/distance * _speed  * FlxG.elapsed;			
					_hostSprite.y += ycomp/distance * _speed  * FlxG.elapsed;
				}			
			}
			
			if (_hostSprite.color == _player.color)
			{
				if (distance > _min_distance )
				{
					_hostSprite.x -= xcomp / distance * _speed  * FlxG.elapsed;		
					_hostSprite.y -= ycomp/distance * _speed  * FlxG.elapsed;
				}		
			}
		}
	}

}