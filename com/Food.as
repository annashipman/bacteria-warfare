package com 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxCore;
	import com.*;
	
	public class Food extends FlxSprite
	{
		[Embed(source = '../../media/fungiblue.png')] private var ImgFungi:Class;
		[Embed(source = '../../media/fungired.png')] private var ImgRedFungi:Class;
		[Embed(source = '../../media/fungigreen.png')] private var ImgGreenFungi:Class;
		[Embed(source = '../../media/fungiyellow.png')] private var ImgYellowFungi:Class;
				
		public var _on:Boolean = false;
		public var _food_colour:int;
		public var _time:Number = 0;
		
		private var radius:Number = 150;
		
		public function Food(X:Number, Y:Number, Color:Number)
		{
			super (X, Y);
			_food_colour = Color;
			switch(Color)
			{
				case Colour.RED :
					loadGraphic(ImgRedFungi, false, false, 36, 36);
				break;
				case Colour.GREEN :
					loadGraphic(ImgGreenFungi, false, false, 36, 36);
				break;
				case Colour.BLUE :
					loadGraphic(ImgFungi, false, false, 36, 36);
				break;
				case Colour.YELLOW :
					loadGraphic(ImgYellowFungi, false, false, 36, 36);
				break;
			}
			
			health = Math.floor(Math.random() * 10) + 15;
			offset.x = 6;
			offset.y = 6;
			scale = new Point(1, 1);
		}
		
		public function resset(X:Number, Y:Number, Color:Number):void
		{
			super.reset(X, Y);
			switch(Color)
			{
				case Colour.RED :
					loadGraphic(ImgRedFungi, false, false, 36, 36);
				break;
				case Colour.GREEN :
					loadGraphic(ImgGreenFungi, false, false, 36, 36);
				break;
				case Colour.BLUE :
					loadGraphic(ImgFungi, false, false, 36, 36);
				break;
				case Colour.YELLOW :
					loadGraphic(ImgYellowFungi, false, false, 36, 36);
				break;
			}
			_food_colour = Color;
			health = Math.floor(Math.random() * 10) + 15;
			offset.x = 6;
			offset.y = 6;
			scale = new Point(1, 1);
		}
		override public function update():void 
		{
			//search for nearby bacteria
			for each(var b:Bacteria in com.GameState._bacteria)
			{
				
				if (b.distanceFrom(this) < radius && b.color==_food_colour)
				{
					b.removeAllBehaviours();
					b.addBehaviour(MoveToPointBehaviour, new Point(x, y), (Math.random() * 40) + 10);//attract them to this food
					if (b.overlaps(this))
					{
						getBitten(b.x, b.y, b.color);
						break;
					}
				}				
			}		
			super.update();
		}
		
		public function getBitten(X:Number, Y:Number,Color:Number):void 
		{
			scale.x -= 0.05
			scale.y -= 0.05
			health -= 1;
			if (health <= 0)
			{
				GameState.addBacteria(X + 20, Y + 20, Color);
				kill();				
			}
		}
		
		override public function kill():void
		{
			//make all nearby bacteria go back to the sink
			for each(var b:Bacteria in com.GameState._bacteria)
			{
				if (b.distanceFrom(this) < radius)
				{
					b.removeAllBehaviours();
					b.addBehaviour(MoveToSinkBehaviour, GameState.testSink);
				}
			}
			super.kill()
		}
	}

}