package com 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Razvan
	 */
	public class CloggedSink extends FlxSprite
	{
		[Embed(source = '../../media/sink-clogged.png')] private var ImgClogged:Class;
		
		public function CloggedSink() 
		{
			super(0, 0);
			loadGraphic(ImgClogged, false, false, 800, 600);
		}
		
	}

}