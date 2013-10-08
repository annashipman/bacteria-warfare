package com 
{
	import com.Behaviour;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Razvan Mocanu
	 * 
	 * A behaviour that makes a FlxSprite go to another FlxSprite
	 */
	public class EatBehaviour extends Behaviour
	{
		protected var _target :FlxSprite;
		protected var _speed :Number;
		
		public function EatBehaviour(HostSprite : FlxSprite, Target : FlxSprite) 
		{
			_target = Target;
			super(HostSprite);
		}
		
		override public function update():void
		{
			//Move towards target
			var xcomp:Number = _hostSprite.x - _target.x
			var ycomp:Number = _hostSprite.y - _target.y
			var distance:Number = Math.sqrt(Math.pow(xcomp, 2) + Math.pow(ycomp, 2));
			
			if (distance<180)
			{
				_speed = 300 - distance;
				_hostSprite.x -= xcomp/distance * _speed  * FlxG.elapsed;			
				_hostSprite.y -= ycomp / distance * _speed  * FlxG.elapsed;
			}
		}
	}

}