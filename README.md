ActionScript Usage
-------

Using NativeMouse is simple:

	...
	var nativeMouse:INativeMouse = new NativeMouse();
	
	if (nativeMouse.isSupported())
	{
		nativeMouse.addEventListener(NativeMouseEvent.NATIVE_MOUSE_MOVE, nativeMouseMoveHandler);
		
		nativeMouse.captureMouse();
	}
	
	private function nativeMouseMoveHandler(event:NativeMouseEvent):void
	{
		this.label.text = new Point(event.mouseX, event.mouseY);
	}
	...

MXML Usage
-------

In MXML use NativeMouseTag wrapper as follow:

	...
	<fx:Declarations>
		<tags:NativeMouseTag id="nativeMouse" enabled="true" />
	</fx:Declarations>
	
	<s:Label text="{nativeMouse.coordinates}" />
	...