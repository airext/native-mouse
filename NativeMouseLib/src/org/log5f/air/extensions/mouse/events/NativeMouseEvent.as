package org.log5f.air.extensions.mouse.events
{
	import flash.events.Event;
	
	import org.log5f.air.extensions.mouse.enum.NativeMouseButton;
	
	public class NativeMouseEvent extends Event
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------

		public static const NATIVE_MOUSE_UP:String				= "nativeMouseUp";

		public static const NATIVE_MOUSE_MOVE:String			= "nativeMouseMove";
		
		public static const NATIVE_MOUSE_DOWN:String			= "nativeMouseDown";
		
		public static const NATIVE_MOUSE_WHEEL:String			= "nativeMouseWheel";
		
		public static const NATIVE_MOUSE_DOUBLE_CLICK:String	= "nativeMouseDoubleClick";
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/** Constructor */
		public function NativeMouseEvent(type:String, button:NativeMouseButton=null, mouseX:Number=NaN, mouseY:Number=NaN, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this._button = button;
			this._mouseX = mouseX;
			this._mouseY = mouseY;
		}
		
		//----------------------------------------------------------------------
		//
		//	Proeprties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	button
		//-----------------------------------
		
		/** @private */
		private var _button:NativeMouseButton;
		
		/** TODO (mrozdobudko): TBD */
		public function get button():NativeMouseButton
		{
			return this._button;
		}
		
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
			return new NativeMouseEvent(this.type, this.button, this.mouseX, 
										this.mouseY, this.bubbles, 
										this.cancelable);
		}
	}
}