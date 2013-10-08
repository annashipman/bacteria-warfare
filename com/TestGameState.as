package com 
{
	import org.flixel.*;
	import flash.geom.Point;
	/**
	 * A test game state to find out why everything is broken
	 * @author D.Hutchison
	 */
	public class TestGameState extends FlxState
	{
		//layers
		public static var lyrSprites:FlxLayer;
		public static var lyrBackground:FlxLayer;
		
		public static var cGrid:Array;
		
		private var bg:Background;
		
		//game objects
		private var testSink:PlugHole;
		private var _bacteria:Array;
		private var player:Player;
		private var counter:int = 0;
		
		public function TestGameState() 
		{
			cGrid = new Array;
			
			for (var i:Number = 0; i <= 800; i++)
			{
				cGrid.push(new Array);
				for (var j:Number = 0; j <= 600; j++)
				{
					cGrid[i][j] = 0;
				}
			}
			
			super();
			lyrSprites = new FlxLayer;
			lyrBackground = new FlxLayer;
			testSink = new PlugHole((FlxG.width / 2) , (FlxG.height / 2) );
			bg = new Background;
			_bacteria = new Array;
			player = new Player(50, 50);
			
			this.add(lyrBackground);
			this.add(lyrSprites);
							
			lyrSprites.add(testSink);
			lyrBackground.add(bg);
			lyrSprites.add(player);
		}
		
		//Add or recycle a bacteria to the state
		public function addBacteria(X:Number, Y:Number, Colour:Number):void
		{
			for (var i:Number = 0; i < _bacteria.length; i++)
			{
				if (_bacteria[i].dead)
				{
					counter += 1;
					_bacteria[i].reset(X, Y);
					_bacteria[i].color = Colour;
					_bacteria[i].addBehaviour(MoveToSinkBehaviour,testSink);
					return;
				}
			}
			
			var newBacteria:Bacteria = new Bacteria(X, Y, Colour);
			newBacteria.addBehaviour(MoveToSinkBehaviour,testSink);
			lyrSprites.add(newBacteria);
			_bacteria.push(newBacteria);			
		}
		
		
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justReleased("X"))
			{
				var c:Number = Math.floor(Math.random()*4);
				switch(c)
				{
					case 0: c = Colour.GREEN; break;
					case 1: c = Colour.RED; break;
					case 2: c = Colour.WHITE; break;
					case 3: c = Colour.YELLOW; break;
				}
				addBacteria(Math.floor(Math.random()*800), Math.floor(Math.random()*600), c);
			}
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				lyrSprites.add(new Food(player.x+31, player.y+53, player._player_colour));
			}
			
			if (counter > 99)
			{
				FlxG.switchState(GameOverState);
			}
			
		}
	}

}