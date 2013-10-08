package com 
{
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author D.Hutchison
	 * 
	 * A Behviour that moves a bacteria to a point, then kills it when it gets there
	 */
	public class MoveToAndDieBehaviour extends Behaviour
	{
		private var _moveBehav:Behaviour;
		public function MoveToAndDieBehaviour(HostSprite:FlxSprite, Destination:Point) 
		{
			super(HostSprite);
			_moveBehav = new MoveToPointBehaviour(_hostSprite, Destination);
		}
		
		override public function update():void
		{
			//move the sprite
			_moveBehav.update();
			
			//check if we have arrived
			if (_moveBehav.isFinished)
			{
				//if so then kill the host sprite
				
			}
		}
		
	}

}