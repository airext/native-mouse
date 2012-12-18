package org.log5f.air.extensions.mouse
{
	import flash.events.IEventDispatcher;

	public interface INativeMouse extends IEventDispatcher
	{	
		function captureMouse():Boolean;
		
		function releaseMouse():Boolean;
		
		function getMouseInfo():Object;
	}
}