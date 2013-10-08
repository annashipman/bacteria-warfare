package com 
{
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author D.Hutchison
	 */
	public class MoveToSinkBehaviour extends Behaviour
	{
		private var _moveToSink:MoveToPointBehaviour;
		
		public function MoveToSinkBehaviour(HostSprite:FlxSprite, Sink:FlxSprite) 
		{
			super(HostSprite);
			_moveToSink = new MoveToPointBehaviour(_hostSprite, new Point(Sink.x, Sink.y), 40);
		}
		
		override public function update():void
		{
			_moveToSink.update();
			if (_moveToSink.isFinished())
			{
				_finished = true;
				GameState.counter += 1;
				
			}
		}
	}

}