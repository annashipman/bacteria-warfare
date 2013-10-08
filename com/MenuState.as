package com 
{
	import org.flixel.*;
	import com.*;
	
	
	public class MenuState extends FlxState
    {
		public static var lyrBackground:FlxLayer;
		private var title:Title;

		override public function MenuState():void
		{
			lyrBackground = new FlxLayer;
			
			title = new Title();
			
			this.add(lyrBackground);
			
			lyrBackground.add(title);
		}
		
		override public function update():void
		{
			if (FlxG.keys.X)
			{
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, onFade);
			}
			if (FlxG.keys.C)
			{
				FlxG.switchState(GameOverState);
			}
			super.update();
		}
		private function onFade():void
		{
			FlxG.switchState(GameState);
		}
	}
}