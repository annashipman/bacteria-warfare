package com 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author D.Hutchison
	 * 
	 * A behaviour that makes a FlxSprite follow a second FlxSprite instance
	 */
	public class FollowBehaviour extends Behaviour
	{
		protected var _target : FlxSprite;
		protected var _speed :Number;
		protected var _min_distance:Number;
		
		public function FollowBehaviour(HostSprite : FlxSprite, Target : FlxSprite, Speed : Number, MinDistance : Number) 
		{
			_target = Target;
			_speed = Speed;
			_min_distance = MinDistance;
			super(HostSprite);	
		}
		
		override public function update():void
		{
			//move towards _target at _speed
			
			var xcomp:Number = _hostSprite.x - _target.x
			var ycomp:Number = _hostSprite.y - _target.y
			var distance:Number = Math.sqrt(Math.pow(xcomp, 2) + Math.pow(ycomp, 2)); 
			
			if (distance > _min_distance)
			{
				_hostSprite.x -= xcomp / distance * _speed  * FlxG.elapsed;		
				_hostSprite.y -= ycomp/distance * _speed  * FlxG.elapsed;
			}
			
			super.update();
		}
	}

}