package com
{
 	/* Class to hold boundaries of sink
	 * @author Anna Shipman
	 */
	public final class SinkBoundaries 
	{
		//for now, don't worry about corners
		public static const LEFT:int = 143;
		public static const TOP: int = 195;
		public static const BOTTOM: int = 495;
		public static const RIGHT: int = 666;
		
		public static const PLUG_LEFT_EDGE: int = 334;
		public static const PLUG_TOP_EDGE: int = 242;
		public static const PLUG_BOTTOM_EDGE: int = 368;
		public static const PLUG_RIGHT_EDGE: int = 462;	
		public static const PLUGHOLE_MIDPOINT_X: int = 	398;	
		public static const PLUGHOLE_MIDPOINT_Y: int = 	305;	
	
		public static function getLeftMovement(X: int, Y: int, SpriteLeft: int, MoveDistance: int) :int
		{	
			var _potential_x: int = X - SpriteLeft - MoveDistance;
			
			//if it's heading out the left it's not going down the plug so can return
			if (_potential_x < LEFT) {
				return LEFT - SpriteLeft;
			}
			
			//otherwise check it's not going left into the plughole
			else {
				if (_potential_x < PLUG_RIGHT_EDGE && _potential_x > PLUG_LEFT_EDGE) {
					if (Y > PLUG_TOP_EDGE && Y < PLUG_BOTTOM_EDGE) {
						return X;
					}
				}
			return _potential_x;
			}
		}
		
		public static function getRightMovement(X: int, Y: int, SpriteRight: int, MoveDistance: int):int
		{
			var _potential_x: int = X + SpriteRight  + MoveDistance;
			
			//if it's heading out the right it's not going down the plug so can return
			if (_potential_x > RIGHT) {
					return RIGHT - SpriteRight;
			}
			
			//otherwise check it's not going right into the plughole
			else {
				if (_potential_x < PLUG_RIGHT_EDGE && _potential_x > PLUG_LEFT_EDGE ) {
					if (Y > PLUG_TOP_EDGE && Y < PLUG_BOTTOM_EDGE) {
						return X;
					}
				}
			return _potential_x;	
			}
		}
		
		public static function getUpMovement(X: int, Y: int, SpriteTop: int, MoveDistance:int):int
		{
			var _potential_y: int = Y + SpriteTop - MoveDistance;
			
			//if it's heading out the top it's not going in the sink so can return
			if (_potential_y < TOP) {
				return _potential_y = TOP - SpriteTop;	
			}
			
			//otherwise, check it's not going up into the plughole
			if (_potential_y < PLUG_BOTTOM_EDGE && _potential_y > PLUG_TOP_EDGE) {
				if ( X > PLUG_LEFT_EDGE && X < PLUG_RIGHT_EDGE ) {
					return Y;
				}
			}
			return _potential_y;
		}
		
		public static function getDownMovement(X: int, Y: int, SpriteBottom: int, MoveDistance: int) :int 
		{
			var _potential_y: int = Y + SpriteBottom + MoveDistance;
			
			//if it's heading out the bottom of the sink it's not going down the plug so can return
			if (_potential_y > BOTTOM) {
				return BOTTOM - SpriteBottom;
			}
			
			//otherwise, check it's not going down into the plughole
			else {
				if (_potential_y < PLUG_BOTTOM_EDGE && _potential_y > PLUG_TOP_EDGE) {
					if (X > PLUG_LEFT_EDGE && X < PLUG_RIGHT_EDGE) {
						return Y;
					}
				}
			return _potential_y;
			}
		}
		  
		//This obviously is not ideal but we're running out of time...!
		public static function slideOnYAxisInstead(X:int, Y:int): int
		{
			var _sliding_coordinate: int;
			if (Y < PLUGHOLE_MIDPOINT_Y) {
				_sliding_coordinate = Y - 4;
				if (_sliding_coordinate < TOP) {
					_sliding_coordinate = Y;
				}
			}
			else {
				_sliding_coordinate = Y + 4;
				if (_sliding_coordinate > BOTTOM) {
					_sliding_coordinate = Y;
				}
			}
			return _sliding_coordinate;
		}
		
		public static function slideOnXAxisInstead(X:int, Y:int): int
		{
			var _sliding_coordinate: int;
			if ( X < PLUGHOLE_MIDPOINT_X) {
				_sliding_coordinate = X - 4;
				if (_sliding_coordinate < LEFT) {
					_sliding_coordinate = X;
				}
			}
			else {
				_sliding_coordinate = X + 4;
				if (_sliding_coordinate > RIGHT) {
					_sliding_coordinate = X;
				}
			}
			return _sliding_coordinate;
		}
	}
}