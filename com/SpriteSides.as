package com 
{
	/**
	 * Class for boundaries to stop sprites escaping the sink
	 * @author Anna Shipman
	 */
	
	public final class SpriteSides 
	{
		//Top and left are required even though they will often be same as x, y
		//because Sprite may not reach to edge of bounding box
		private var _left: int;
		private var _right: int;
		private var _top: int;
		private var _bottom: int;
		
		
		public function SpriteSides(Left:int, Right:int, Top:int, Bottom: int) 
		{
			_left = Left;
			_right = Right;
			_top = Top;
			_bottom = Bottom;
		}
		
		public const LEFT: int = _left;
		public const RIGHT: int = _right;
		public const TOP: int = _top;
		public const BOTTOM: int = _bottom;
		
	}

}