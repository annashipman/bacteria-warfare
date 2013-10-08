package com 
{
	import org.flixel.FlxSprite
	/**
	 * ...
	 * @author ...
	 */
	public class Title extends FlxSprite
	{
		[Embed(source = '../../media/title.png')] private var ImgTitle:Class;
		
		public function Title() 
		{
			super(0, 0);
			loadGraphic(ImgTitle, false, false, 800, 600)
		}
		
	}

}