package com 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author D.Hutchison
	 */
	public class PlugHole extends FlxSprite
	{
		[Embed(source = '../../media/sinkscum1.png')] private var ImgScum1:Class;
		[Embed(source = '../../media/sinkscum2.png')] private var ImgScum2:Class;
		[Embed(source = '../../media/sinkscum3.png')] private var ImgScum3:Class;
		[Embed(source = '../../media/sinkscum4.png')] private var ImgScum4:Class;
		[Embed(source = '../../media/sinkscum5.png')] private var ImgScum5:Class;
		[Embed(source = '../../media/sinkscum6.png')] private var ImgScum6:Class;
		[Embed(source = '../../media/sinkscum8.png')] private var ImgScum7:Class;
		
		
		public function PlugHole(X:Number,Y:Number) 
		{
			super(400, 300);			
			offset.x = 400;
			offset.y = 300;
			changeImage(1);
		}
		
		public function changeImage(costume:Number):void
		{
			switch (costume)
			{
				
				case 1:
				loadGraphic(ImgScum1, false, false, 800, 600);
				break;
				case 2:
				loadGraphic(ImgScum2, false, false, 800, 600);
				break;
				case 3:
				loadGraphic(ImgScum3, false, false, 800, 600);
				break;
				case 4:
				loadGraphic(ImgScum4, false, false, 800, 600);
				break;
				case 5:
				loadGraphic(ImgScum5, false, false, 800, 600);
				break;
				case 6:
				loadGraphic(ImgScum6, false, false, 800, 600);
				break;
				case 7:
				loadGraphic(ImgScum7, false, false, 800, 600);
				break;
				default:
				break;
			}
		}
		
	}

}