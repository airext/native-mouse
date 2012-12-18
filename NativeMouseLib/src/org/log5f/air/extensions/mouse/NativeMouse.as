package org.log5f.air.extensions.mouse
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	import org.log5f.air.extensions.mouse.events.NativeMouseEvent;
	import org.log5f.air.extensions.mouse.enum.NativeMouseButton;
	
	[Event(name="nativeMouseMove", type="org.log5f.air.extensions.mouse.events.NativeMouseEvent")]
	[Event(name="nativeMouseDown", type="org.log5f.air.extensions.mouse.events.NativeMouseEvent")]
	[Event(name="nativeMouseUp", type="org.log5f.air.extensions.mouse.events.NativeMouseEvent")]
	
	public class NativeMouse extends EventDispatcher implements INativeMouse
	{
		//----------------------------------------------------------------------
		//
		//	Class cosntants
		//
		//----------------------------------------------------------------------
		
		/** @priate */
		private static const ID:String = "org.log5f.air.extensions.mouse.NativeMouse";
		
		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
		/** @priate */
		private static var context:ExtensionContext = null;
		
		//----------------------------------------------------------------------
		//
		//	Static initialization
		//
		//----------------------------------------------------------------------
		
		{
			context = ExtensionContext.createExtensionContext(ID, null);
		}
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/** @inheritDoc */
		public static function isSupported():Boolean
		{
			return context && context.call("isSupported") as Boolean;
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/** Constructor */
		public function NativeMouse()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------

		//-----------------------------------
		//	Methods: INativeMouse
		//-----------------------------------
		
		/** @inheritDoc */
		public function captureMouse():Boolean
		{
			const result:Boolean = context.call("captureMouse") as Boolean;
			
			if (result)
			{
				context.addEventListener(StatusEvent.STATUS, statusHandler);
			}
			
			return result;
		}
		
		/** @inheritDoc */
		public function releaseMouse():Boolean
		{
			const result:Boolean = context.call("releaseMouse") as Boolean;
			
			context.removeEventListener(StatusEvent.STATUS, statusHandler);
			
			return result;
		}
		
		/** @inheritDoc */
		public function getMouseInfo():Object
		{
			var result:Object = {};
			
			context.call("getMouseInfo", result);
			
			return result;
		}
		
		//----------------------------------------------------------------------
		//
		//	Handlers
		//
		//----------------------------------------------------------------------

		/** @private */
		private function statusHandler(event:StatusEvent):void
		{
			var info:Object;
			var code:String = event.code;
			var button:NativeMouseButton = null;
			
			if (code.search("LeftButton") != -1)
				button = NativeMouseButton.LEFT;
			else if (code.search("MiddleButton") != -1)
				button = NativeMouseButton.MIDDLE;
			else if (code.search("RightButton") != -1)
				button = NativeMouseButton.RIGHT;
			
			switch (code)
			{
				case "Mouse.Move" :
					
					info = this.getMouseInfo();
					
					this.dispatchEvent(new NativeMouseEvent(
						NativeMouseEvent.NATIVE_MOUSE_MOVE, null, info.mouseX, info.mouseY));
					
					break;
				
				case "Mouse.Wheel" :
					
					info = this.getMouseInfo();
					
					this.dispatchEvent(new NativeMouseEvent(
						NativeMouseEvent.NATIVE_MOUSE_WHEEL, null, info.mouseX, info.mouseY));
					
					break;
				
				case "Mouse.Up.LeftButton" :
				case "Mouse.Up.MiddleButton" :
				case "Mouse.Up.RightButton" :
					
					info = this.getMouseInfo();
					
					this.dispatchEvent(new NativeMouseEvent(
						NativeMouseEvent.NATIVE_MOUSE_UP, button, info.mouseX, info.mouseY));
					
					break;
				
				case "Mouse.Down.LeftButton" :
				case "Mouse.Down.MiddleButton" :
				case "Mouse.Down.RightButton" :
					
					info = this.getMouseInfo();
					
					this.dispatchEvent(new NativeMouseEvent(
						NativeMouseEvent.NATIVE_MOUSE_DOWN, button, info.mouseX, info.mouseY));
					
					break;

				case "Mouse.DoubleClick.LeftButton" :
				case "Mouse.DoubleClick.MiddleButton" :
				case "Mouse.DoubleClick.RightButton" :
					
					info = this.getMouseInfo();
					
					this.dispatchEvent(new NativeMouseEvent(
						NativeMouseEvent.NATIVE_MOUSE_DOUBLE_CLICK, button, info.mouseX, info.mouseY));
					
					break;
			}
		}
	}
}