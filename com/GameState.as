package com 
{
	import org.flixel.*;
	import flash.geom.Point;
	
	/**
	 * Game state 
	 * @author D.Hutchison
	 */
	public class GameState extends FlxState
	{
		[Embed(source = '../../media/ggj2010.mp3')] private var Music:Class;

		//layers
		public static var lyrSprites:FlxLayer;
		public static var lyrBackground:FlxLayer;
		public static var lyrTap: FlxLayer;
		
		private var bg:Background;
		private var tap: Tap;
		
		private var audio:FlxSound;
		
		public static var points:Number;
				
		//game objects
		public static var testSink:PlugHole;
		public static var _bacteria:Array;
		public static var _foods:Array;
		public static var counter:int = 0;
		
		private var _score:FlxText;
		private var _bacteriaCounter:FlxText;
		
		private var player:Player;
		
		private var timer:Number;
		
		private var nextLevel:Number;
		
		public function GameState() 
		{			
			super();
			lyrSprites = new FlxLayer;
			lyrBackground = new FlxLayer;
			lyrTap = new FlxLayer;
			
			testSink = new PlugHole((FlxG.width / 2) , (FlxG.height / 2) );
			bg = new Background;
			tap = new Tap;
			audio = new FlxSound()
			audio.loadEmbedded(Music);
			audio.play();
			_bacteria = new Array;
			_foods = new Array;
			player = new Player(200, 200);
			
			this.add(lyrBackground);
			this.add(lyrSprites);
			this.add(lyrTap);
			points = 0;
			timer = 0;
			
			lyrBackground.add(bg);
			lyrBackground.add(testSink);
			lyrTap.add(tap);
			lyrSprites.add(player);
			
			nextLevel = 4.3;
			
			_score = new FlxText(550, 50, 200, "Points =");
			_bacteriaCounter = new FlxText(550, 80, 200, "Escapers =");
			add(_score);
			add(_bacteriaCounter);
			_score.size = _bacteriaCounter.size = 20;
		}
		
		//Add or recycle a bacteria to the state
		static public function addBacteria(X:Number, Y:Number, Colour:Number):void
		{
			for (var i:Number = 0; i < _bacteria.length; i++)
			{
				if (_bacteria[i].dead)
				{
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
		
		public function addFood(X:Number,Y:Number):void
		{
			for (var i:Number = 0; i < _foods.length; i++)
			{
				if (_foods[i].dead)
				{
					_foods[i].resset(X, Y,player._player_colour);					
					return;
				}
			}
			var newfoods:Food = new Food(X, Y, player._player_colour);
			lyrBackground.add(newfoods);
			_foods.push(newfoods);
		}
		
		public function addRandomBacteria():void
		{
			var _random_x: int;
			var _random_y: int;
			
			var c:Number = Math.floor(Math.random()*4);
			switch(c)
			{
				case 0: 
					c = Colour.GREEN; 
					_random_x = SinkBoundaries.LEFT;
					_random_y = Math.round(Math.random() * (SinkBoundaries.BOTTOM - SinkBoundaries.TOP) + SinkBoundaries.TOP);
					break;
				case 1: 
					c = Colour.YELLOW; 
					_random_x = SinkBoundaries.RIGHT + 8;//size of bacteria
					_random_y = Math.round(Math.random() * (SinkBoundaries.BOTTOM - SinkBoundaries.TOP) + SinkBoundaries.TOP);;
					break;
				case 2: 
					c = Colour.RED; 
					_random_x = Math.round(Math.random() * (SinkBoundaries.RIGHT - SinkBoundaries.LEFT) + SinkBoundaries.LEFT);
					_random_y = SinkBoundaries.BOTTOM + 10;//hack because something funny with boundary methods
					break;
				case 3: 
					c = Colour.BLUE; 
					_random_x = Math.round(Math.random() * (SinkBoundaries.RIGHT - SinkBoundaries.LEFT) + SinkBoundaries.LEFT);
					_random_y = SinkBoundaries.TOP;
					break;
			}
			
			addBacteria(_random_x, _random_y, c);
		}
		override public function update():void
		{
			super.update();
			
			//check for collsions between food and bacteria			
			timer += FlxG.elapsed;
			points += Math.floor(FlxG.elapsed * 100);
			
			_score.text = "Points = " + points;
			_bacteriaCounter.text = "Escapers = " + counter;
			if (timer > nextLevel)
			{
				timer = 0;
				if(nextLevel >0.2){
				nextLevel -= 0.05;}
				addRandomBacteria();
			}
			
			if (FlxG.keys.justReleased("X"))
			{
				addRandomBacteria();
			}
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				//if (player.addFood()){
				addFood(player.x+2, player.y+30);//}
			}
			
			switch(counter)
			{
				case 16: testSink.changeImage(1); tap.jiggleIntensity =1.5; break;
				case 33: testSink.changeImage(2); tap.jiggleIntensity =2;break;
				case 49: testSink.changeImage(3); tap.jiggleIntensity =2.5;break;
				case 66: testSink.changeImage(4); tap.jiggleIntensity =3;break;
				case 83: testSink.changeImage(5); tap.jiggleIntensity =4;break;
				case 98: testSink.changeImage(6); tap.jiggleIntensity =5;break;
			}			
				if (counter >= 100)
				{
					lyrSprites.kill();
					FlxG.switchState(GameOverState);
				}
			}
		}
}

