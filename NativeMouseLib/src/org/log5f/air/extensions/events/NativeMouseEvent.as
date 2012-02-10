package org.log5f.air.extensions.events
{
	import flash.events.Event;
	
	public class NativeMouseEvent extends Event
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		public static const NATIVE_MOUSE_DOWN:String	= "nativeMosueDown";

		public static const NATIVE_MOUSE_UP:String		= "nativeMosueUp";

		public static const NATIVE_MOUSE_MOVE:String	= "nativeMosueMove";
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/** Constructor */
		public function NativeMouseEvent(type:String, mouseX:Number=NaN, mouseY:Number=NaN, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this._mouseX = mouseX;
			this._mouseY = mouseY;
		}
		
		//----------------------------------------------------------------------
		//
		//	Proeprties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	mouseX
		//-----------------------------------
		
		/** @private */
		private var _mouseX:Number;
		
		/** TODO (mrozdobudko): TBD */
		public function get mouseX():Number
		{
			return this._mouseX;
		}
		
		//-----------------------------------
		//	mouseY
		//-----------------------------------
		
		/** @private */
		private var _mouseY:Number;
		
		/** TODO (mrozdobudko): TBD */
		public function get mouseY():Number
		{
			return this._mouseY;
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------
		
		/** @inheritDoc */
		override public function clone():Event
		{
			return new NativeMouseEvent(this.type, this.mouseX, this.mouseY, 
										this.bubbles, this.cancelable);
		}
	}
}