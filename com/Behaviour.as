package com 
{
	import org.flixel.FlxSprite;	
	
	public class Behaviour
	{
		protected var _hostSprite :FlxSprite;
		protected var _finished : Boolean = false;
		
		public function Behaviour(HostSprite : FlxSprite):void 
		{
			_hostSprite = HostSprite;
			_finished = false;
		}
		
		public function isFinished():Boolean
		{
			return _finished;
		}
		
		public function update():void
		{
			
		}
	}

	
}