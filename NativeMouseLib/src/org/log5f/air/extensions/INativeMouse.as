package org.log5f.air.extensions
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;

	public interface INativeMouse extends IEventDispatcher
	{
		function isSupported():Boolean;
		
		function captureMouse():Boolean;
		
		function releaseMouse():Boolean;
		
		function getMouseInfo():Object;
	}
}