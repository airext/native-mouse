Overview
-------

The NativeMouse is a simple extension for Adobe AIR for Desktop that provides information about system mouse.

ActionScript Usage
-------

Getting mouse current position through `getMouseInfo()` method:

	...
	
	if (NativeMouse.isSupported)
	{
		var info:Object = new NativeMouse().getMouseInfo();
		
		trace(info.mouseX, info.mouseY);
	}
	
	...

Using `NativeMouse` asynchronously:

	...

	if (NativeMouse.isSupported())
	{
		var nativeMouse:INativeMouse = new NativeMouse();
	
		nativeMouse.addEventListener(NativeMouseEvent.NATIVE_MOUSE_MOVE, nativeMouseHandler);
		nativeMouse.addEventListener(NativeMouseEvent.NATIVE_MOUSE_DOWN, nativeMouseHandler);
		
		nativeMouse.captureMouse();
	}
	
	private function nativeMouseHandler(event:NativeMouseEvent):void
	{
		this.mousePositionLabel.text = new Point(event.mouseX, event.mouseY);
		
		switch (event.button)
		{
			case NativeMouseButton.LEFT :
				// 
				break;
			
			case NativeMouseButton.RIGHT :
				// 
				break;
		}
	}
	...

MXML Usage
-------

The `NativeMouseTag` is designed to be used in MXML code: 

	...
	<fx:Declarations>
		<tags:NativeMouseTag id="nativeMouse" enabled="true" />
	</fx:Declarations>
	
	<s:Label text="{nativeMouse.coordinates}" />
	...
	

References
-------

Code from [DesktopMouse](https://github.com/pcichon/DesktopMouse) has been used for getMouseInfo() for Windows.
