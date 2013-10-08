package com 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author D.Hutchison
	 */
	public class Background extends FlxSprite
	{
		[Embed(source = '../../media/sink7.PNG')] private var ImgBackground:Class;

		public function Background() 
		{
			super(0, 0);
			loadGraphic(ImgBackground, false, false, 800, 600)
		}
		
	}

}