package org.log5f.air.extensions
{
	/**
	 * The NativeMouseButton class contains enumeration of mouse buttons.
	 * 
	 * @see org.log5f.air.extensions.NativeMouseEvent.button
	 */
	public class NativeMouseButton
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/** Represents mouse left button */
		public static const LEFT:NativeMouseButton		= new NativeMouseButton("left");
		
		/** Represents mouse left button */
		public static const MIDDLE:NativeMouseButton	= new NativeMouseButton("middle");

		/** Represents mouse left button */
		public static const RIGHT:NativeMouseButton		= new NativeMouseButton("right");
		
		//----------------------------------------------------------------------
		//
		//	Static initialization 
		//
		//----------------------------------------------------------------------
		
		private static var initialized:Boolean = false;
		
		{
			initialized = true;
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor 
		//
		//----------------------------------------------------------------------
		
		/** Constructor */
		public function NativeMouseButton(name:String)
		{
			super();
			
			if (initialized)
				throw new Error("Use constants from NativeMouseButton class.");
			
			this._name = name;
		}
		
		//----------------------------------------------------------------------
		//
		//	Properties 
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	name
		//-----------------------------------
		
		/** @private */
		private var _name:String;
		
		/** Stores button's name. */
		public function get name():String
		{
			return _name;
		}
	}
}