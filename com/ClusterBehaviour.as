package com 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/*
	 * A behaviour to make bacteria try to cluster together
	 */
	
	public class ClusterBehaviour extends Behaviour
	{
		private var _target:FlxSprite;
		private var _speed:Number = 25;
		private const _min_distance:Number = 15;
		public function ClusterBehaviour(HostSprite:FlxSprite, Target:FlxSprite) 
		{
			super(HostSprite);
			_target = Target;
		}
		
		override public function update():void
		{
			var xcomp:Number = _hostSprite.x - _target.x;
			var ycomp:Number = _hostSprite.y - _target.y;
			
			var distance:Number = Math.sqrt(Math.pow(xcomp, 2) + Math.pow(ycomp, 2)); 
			
			//move slightly towards nearest bacteria
			if (distance > _min_distance)
			//if it gets too close
			{
				_hostSprite.x -= xcomp/distance * _speed  * FlxG.elapsed;			
				_hostSprite.y -= ycomp/distance * _speed  * FlxG.elapsed;
			}			
		}
	}

}