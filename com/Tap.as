package com 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Anna Shipman
	 */
	public class Tap extends FlxSprite
	{
		[Embed(source = '../../media/sink7tap.png')] private var ImgBackground:Class;

		public var jiggleIntensity:Number;
		private var jDir:Number;
		
		public function Tap() 
		{
			jiggleIntensity = jDir= 1;
			super(0, 0);
			loadGraphic(ImgBackground, false, false, 800, 600)
		}
		
		public function jiggle():void
		{
			x += jDir * jiggleIntensity;
			jDir *= -1;
		}
		
		override public function update():void 
		{
			jiggle();
			super.update();
		}
	}

}