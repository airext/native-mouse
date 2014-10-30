## native-mouse ![License MIT](http://img.shields.io/badge/license-MIT-lightgray.svg)

![Windows](http://img.shields.io/badge/platform-windows-yellow.svg)

The NativeMouse is a simple extension for Adobe AIR for Desktop that provides information about system mouse.

## Pure ActionScript Usage

Getting mouse current position through `getMouseInfo()` method:
```as3
if (NativeMouse.isSupported())
{
	var info:Object = new NativeMouse().getMouseInfo();
	
	trace(info.mouseX, info.mouseY);
}
```

Using `NativeMouse` asynchronously:

```as3
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
			
		case NativeMouseButton.MIDDLE :
			// 
			break;
	}
}
```

## MXML Usage

The `NativeMouseTag` is designed to be used in MXML code: 

```mxml
<fx:Declarations>
	<tags:NativeMouseTag id="nativeMouse" enabled="true" />
</fx:Declarations>

<s:Label text="{nativeMouse.coordinates}" />
```

## Donating
Support this project an others via [Gratipay](https://gratipay.com/rozd/).

[![Support via Gratipay](https://cdn.rawgit.com/gratipay/gratipay-badge/2.1.3/dist/gratipay.png)](https://gratipay.com/rozd/)

## References

Code from [DesktopMouse](https://github.com/pcichon/DesktopMouse) has been used for getMouseInfo() for Windows.
