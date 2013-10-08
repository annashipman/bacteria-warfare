package com 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Razvan
	 * 
	 */
	public class GameOverState extends FlxState
	{
		public static var lyrBackground:FlxLayer; 
		
		private var bg:Background;
		private var tap: Tap;
		private var sink:PlugHole;
		
		private var timer:Number;
		
		public function GameOverState() 
		{
			bg = new Background();
			tap = new Tap();
			sink = new PlugHole((FlxG.width / 2) , (FlxG.height / 2));
			
			lyrBackground = new FlxLayer;
			
			this.add(lyrBackground);
			
			lyrBackground.add(bg);
			lyrBackground.add(sink);
			lyrBackground.add(tap);
			//lyrBackground.add(end);
			
		}
		
		override public function update():void
		{
			super.update();
			sink.changeImage(6);
			timer += FlxG.elapsed;
			sink.changeImage(7);
		}
		
	}

}