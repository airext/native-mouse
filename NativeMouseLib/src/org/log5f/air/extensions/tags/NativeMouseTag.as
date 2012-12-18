package org.log5f.air.extensions.tags
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.IMXMLObject;
	import mx.events.PropertyChangeEvent;
	
	import org.log5f.air.extensions.mouse.NativeMouse;
	import org.log5f.air.extensions.mouse.events.NativeMouseEvent;
	
	//-------------------------------------
	//	Events
	//-------------------------------------
	
	/** The internal event that dispatched in response to any mouse activity. */
	[Event(name="nativeMouseChange", type="flash.events.Event")]
	
	/** Adapts NativeMouse to using in MXML. */
	public class NativeMouseTag extends NativeMouse implements IMXMLObject
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/** Used as type of internal event. */
		private static const NATIVE_MOUSE_CHANGE:String	= "nativeMouseChange";
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/** Constructor */
		public function NativeMouseTag()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/** Indicates if mouse is tracked  now. */
		private var isCaptured:Boolean = false;
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	enabled
		//-----------------------------------
		
		/** @private */
		private var _enabled:Boolean;
		
		[Bindable(event="propertyChange")]
		/** TODO (mrozdobudko): TBD */
		public function get enabled():Boolean
		{
			return this._enabled;
		}
		
		/** @private */
		public function set enabled(value:Boolean):void
		{
			if (value === this._enabled)
				return;
			
			const oldValue:Boolean = this._enabled;
			
			this._enabled = value;
			
			if (this._enabled)
				this.on();
			else
				this.off();
			
			this.dispatchEvent(PropertyChangeEvent.
				createUpdateEvent(this, "enabled", oldValue, value));
		}
		
		//-----------------------------------
		//	coordinates
		//-----------------------------------
		
		/** @private */
		private var _coordinates:Point;
		
		[Bindable(event="nativeMouseChange")]
		/** TODO (mrozdobudko): TBD */
		public function get coordinates():Point
		{
			return this._coordinates;
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	Methods: IMXMLObject
		//-----------------------------------
		
		/** @inheritDoc */
		public function initialized(document:Object, id:String):void
		{
			if (this.enabled)
			{
				this.on();
			}
		}

		//-----------------------------------
		//	Methods: Common
		//-----------------------------------
		
		/** Starts watching mouse activity. */
		protected function on():void
		{
			if (this.isCaptured)
				return;
			
			if (NativeMouse.isSupported())
			{
				this.isCaptured = true;
				
				this.addEventListener(NativeMouseEvent.NATIVE_MOUSE_UP, nativeMouseUpHandler);
				this.addEventListener(NativeMouseEvent.NATIVE_MOUSE_MOVE, nativeMouseMoveHandler);
				this.addEventListener(NativeMouseEvent.NATIVE_MOUSE_DOWN, nativeMouseDownHandler);
				this.addEventListener(NativeMouseEvent.NATIVE_MOUSE_WHEEL, nativeMouseWheelHandler);
				this.addEventListener(NativeMouseEvent.NATIVE_MOUSE_DOUBLE_CLICK, nativeMouseDoubleClickHandler);
				
				this.captureMouse();
			}
		}
		
		/** Stops watching mouse activity. */
		protected function off():void
		{
			if (!this.isCaptured)
				return;
			
			if (NativeMouse.isSupported())
			{
				this.isCaptured = false;
				
				this.removeEventListener(NativeMouseEvent.NATIVE_MOUSE_UP, nativeMouseUpHandler);
				this.removeEventListener(NativeMouseEvent.NATIVE_MOUSE_MOVE, nativeMouseMoveHandler);
				this.removeEventListener(NativeMouseEvent.NATIVE_MOUSE_DOWN, nativeMouseDownHandler);
				this.removeEventListener(NativeMouseEvent.NATIVE_MOUSE_WHEEL, nativeMouseWheelHandler);
				this.removeEventListener(NativeMouseEvent.NATIVE_MOUSE_DOUBLE_CLICK, nativeMouseDoubleClickHandler);
				
				this.releaseMouse();
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/** @private */
		private function nativeMouseUpHandler(event:NativeMouseEvent):void
		{
			this.dispatchEvent(new Event(NATIVE_MOUSE_CHANGE));
		}
		
		/** @private */
		private function nativeMouseMoveHandler(event:NativeMouseEvent):void
		{
			this._coordinates = new Point(event.mouseX, event.mouseY);
			
			this.dispatchEvent(new Event(NATIVE_MOUSE_CHANGE));
		}
		
		/** @private */
		private function nativeMouseDownHandler(event:NativeMouseEvent):void
		{
			this.dispatchEvent(new Event(NATIVE_MOUSE_CHANGE));
		}
		
		/** @private */
		private function nativeMouseWheelHandler(event:NativeMouseEvent):void
		{
			this.dispatchEvent(new Event(NATIVE_MOUSE_CHANGE));
		}
		
		/** @private */
		private function nativeMouseDoubleClickHandler(event:NativeMouseEvent):void
		{
			this.dispatchEvent(new Event(NATIVE_MOUSE_CHANGE));
		}
	}
}