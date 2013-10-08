package com 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.flixel.FlxSprite;
	import com.Behaviour;
	import com.Colour;
	
	public class Bacteria extends FlxSprite
	{
		[Embed(source = '../../media/badbaccolum.png')] private var BacteriaSpriteSheet:Class;
		
		private var nearbyBacteria:Array;
		private var _move_speed:int = 70;
		private var _destination:Point;
		private var _behaviours:Array;
		private var _behavDictionary:Dictionary;		
		private var _nearbyFood:Array;//array of nearby food		
		
		private var _spriteSides: SpriteSides;
		public var state:String;
		
		public function Bacteria(X:int, Y:int, Color:int):void
		{
			super(X, Y);
			
			//set Sprite sides
			_spriteSides = new SpriteSides(X, X + 8, Y, Y + 8);
			
			state = "normal";
			
			nearbyBacteria = new Array;
			_nearbyFood = new Array;
			loadGraphic(BacteriaSpriteSheet, true, false, 12, 12); 
			width = 8;
			height = 8;
			
			_behaviours = new Array;			
			nearbyBacteria = new Array;			
			_behavDictionary = new Dictionary();		
			color = Color;
						
			addAnimation("standard0", [0,1,2,3,4,5,6,7],15);
		}
		
		override public function reset(X:Number,Y:Number):void
		{
			super.reset(X, Y);
			removeAllBehaviours();
			scale = new Point(1, 1);
			color = Colour.WHITE;
			nearbyBacteria = new Array;
			_nearbyFood = new Array;
			state = "normal";
		}
		override public function kill():void
		{
			super.kill();
			//do death effect here
			removeAllBehaviours();
		}
		
		/*
		 * Add a behaviour to this bacteria
		 * Extra arguments can be added and will be passed to the Behaviour's constructor
		 */
		public function addBehaviour(Behav:Class, ... rest):void
		{
			//check if this behaviour is already attached
			if (_behavDictionary[Behav] == undefined)
			{
				//assumes a behaviour wants no more than 4 arguments - pretty easy(tedious) to fix
				switch (rest.length)
				{
					case 0:	_behavDictionary[Behav] = _behaviours.push(new Behav(this))-1; return;
					case 1:	_behavDictionary[Behav] = _behaviours.push(new Behav(this,rest[0]))-1; return;
					case 2:	_behavDictionary[Behav] = _behaviours.push(new Behav(this,rest[0],rest[1]))-1; return;
					case 3:	_behavDictionary[Behav] = _behaviours.push(new Behav(this,rest[0],rest[1],rest[2]))-1; return;
				}
			}			
		}
		
		/*
		 * Removes a specific behaviour from the bacteria
		 * Returns a Boolean indicating whether removal was successful
		 */
		public function removeBehaviour(Behav:Class):Boolean
		{
			//check if this behaviour is attached
			if (_behavDictionary[Behav] != undefined)
			{
				_behaviours.splice(_behavDictionary[Behav], 1);
				
				//-1 from all values in dictionary greater than _behavDictionary[Behav] (as splice is destructive)
				for each(var index:Number in _behavDictionary)
				{
					if (index > _behavDictionary[Behav])
					{
						index--;
					}
				}
				_behavDictionary[Behav] = undefined;
				
				return true;
			}
			else
			{				
				return false;
			}
		}
		
		public function removeAllBehaviours():void
		{
			_behaviours = new Array;
			_behavDictionary = new Dictionary;
		}
		
		override public function update():void
		{
			super.update();
			if (!dead)
			{
				updateBehaviours();		
				play("standard0");
				switch(state)
				{
					case "normal":
					//addBehaviour(MoveToSinkBehaviour, GameState.testSink, 200, 50)
					break;
					case "repel":
					//check if we have finished running, then go back to normal
									
					break;
				}				
			}
		}
		
		private function updateBehaviours():void
		{
			var finishedBehaviours:Array = new Array;//array of indices that represent behaviours that have finished
			
			//check for final condition
			if (_behaviours[0] == undefined )
			{
				kill();
				return;
			}			
						
			//update behaviours
			for (var i:Number = 0; i < _behaviours.length;i++)
			{
				_behaviours[i].update()
				
				//if this behaviour is finished, add its index to the removal array
				if (_behaviours[i].isFinished())
				{
					finishedBehaviours.push(i-finishedBehaviours.length);//-length because the splice is destructive!
				}
			}
			
			//remove finished behaviours
			for each (var j:Number in finishedBehaviours)
			{
				_behaviours.splice(j, 1);
			}			
		}
		
		public function distanceFrom(otherSprite:FlxSprite):Number
		{
			var point:Point = new Point(0,0);
			point.x = x - otherSprite.x;
			point.y = y - otherSprite.y;
			return Math.sqrt(Math.pow(point.x, 2) + Math.pow(point.y, 2)); 			
		}
		
	}
}

