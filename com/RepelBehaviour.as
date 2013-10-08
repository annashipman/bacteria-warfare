package com
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Anna Shipman
	 */
	public class RepelBehaviour extends Behaviour 
	{
	
		protected var _repellant :FlxSprite;
		protected var _speed :Number;
		protected var _min_distance:Number;
		protected var _max_distance:Number = 200;
		
		//will the avatar be a FlxSprite too? Or do we need two behaviours?
		public function RepelBehaviour(HostSprite : *, Repellant : FlxSprite, Speed : Number, MinDistance : Number) 
		{
			_repellant = Repellant;
			_speed = Speed;
			_min_distance = MinDistance;
			HostSprite.state = "normal";
			super(HostSprite as FlxSprite);				
		}
		
		override public function update():void
		{
			//move away from  _repellant at _speed if it is within _min_distance 
			//TODO and a different colour
			
			var xcomp:Number = _hostSprite.x - _repellant.x
			var ycomp:Number = _hostSprite.y - _repellant.y
			
			var distance:Number = Math.sqrt(Math.pow(xcomp, 2) + Math.pow(ycomp, 2)); 
			
			if(_hostSprite.color != _repellant.color)
			{
				if (distance < _min_distance)
				//if it gets too close
				{
					_hostSprite.x += xcomp/distance * _speed  * FlxG.elapsed;			
					_hostSprite.y += ycomp/distance * _speed  * FlxG.elapsed;
				}
				//this should stop when it gets far enough away
			}
			if (distance >= _max_distance)
			{
				_finished = true;
				
			}
			//this should stop when it gets far enough away
		}
		
	}
	
}