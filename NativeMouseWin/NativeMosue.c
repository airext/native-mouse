/*
 * SampleANE.c
 *
 *  Created on: Feb 9, 2012
 *      Author: mrozdobudko
 */

#include <string.h>
#include <stdlib.h>

#include "windows.h"
#include "winuser.h"

#include "FlashRuntimeExtensions.h"
#include "NativeMouse.h"


//------------------------------------------------------------------------------
//
//	Variables
//
//------------------------------------------------------------------------------

FREContext context;

HHOOK mouseHook;

//------------------------------------------------------------------------------
//
//	Private Functions
//
//------------------------------------------------------------------------------

void dispatchMouseEvent(const uint8_t* code)
{
	FREDispatchStatusEventAsync(context, code, (const uint8_t *) "info");
}

//------------------------------------------------------------------------------
//
//	Windows Mouse Hook
//
//------------------------------------------------------------------------------

LRESULT CALLBACK LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam)
{
    if (nCode >= 0)
    {

        switch (wParam)
        {
            case WM_LBUTTONDOWN :
            	dispatchMouseEvent((const uint8_t*) "Mouse.Down.LeftButton");
                break;

            case WM_LBUTTONUP :
            	dispatchMouseEvent((const uint8_t*) "Mouse.Up.LeftButton");
                break;

            case WM_MOUSEMOVE :
            	dispatchMouseEvent((const uint8_t*) "Mouse.Move");
            	break;
        }
    }

    return CallNextHookEx(mouseHook, nCode, wParam, lParam);
}

//------------------------------------------------------------------------------
//
//	Shared Functions
//
//------------------------------------------------------------------------------

FREObject isSupported(FREContext ctx, void* functionData, uint32_t argc, FREObject argv[])
{
	FREObject result;

	uint32_t isUpportedInThisOS = 1;

	FRENewObjectFromBool(isUpportedInThisOS, &result);

	return result;
}

FREObject captureMouse(FREContext ctx, void* functionData, uint32_t argc, FREObject argv[])
{
	FREObject result;

	mouseHook = SetWindowsHookEx(WH_MOUSE_LL, &LowLevelKeyboardProc, GetModuleHandleA(NULL), 0);

	BOOL succeed = mouseHook != NULL;

	FRENewObjectFromBool((uint32_t) succeed, &result);

	return result;
}

FREObject releaseMouse(FREContext ctx, void* functionData, uint32_t argc, FREObject argv[])
{
	FREObject result;

	BOOL succeed = UnhookWindowsHookEx(mouseHook);

	mouseHook = NULL;

	FRENewObjectFromBool((uint32_t) succeed, &result);

	return result;
}

FREObject getMouseInfo(FREContext ctx, void* functionData, uint32_t argc, FREObject argv[])
{
	FREObject result = argv[0];

	POINT mouse;

	GetCursorPos(&mouse);

	int32_t x = (int32_t) mouse.x;
	int32_t y = (int32_t) mouse.y;

	FREObject mouseX;
	FREObject mouseY;

	FRENewObjectFromInt32(x, &mouseX);
	FRENewObjectFromInt32(y, &mouseY);

	FRESetObjectProperty(result, (const uint8_t*) "mouseX", mouseX, NULL);
	FRESetObjectProperty(result, (const uint8_t*) "mouseY", mouseY, NULL);

	return NULL;
}

//------------------------------------------------------------------------------
//
//	Context Initializer/Finalizer
//
//------------------------------------------------------------------------------

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
	*numFunctions = 4;

	FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));

	func[0].name = (const uint8_t*) "isSupported";
	func[0].function = &isSupported;
	func[0].functionData = NULL;

	func[1].name = (const uint8_t*) "captureMouse";
	func[1].function = &captureMouse;
	func[1].functionData = NULL;

	func[2].name = (const uint8_t*) "releaseMouse";
	func[2].function = &releaseMouse;
	func[2].functionData = NULL;

	func[3].name = (const uint8_t*) "getMouseInfo";
	func[3].function = &getMouseInfo;
	func[3].functionData = NULL;

	*functions = func;

	context = ctx;
}

void contextFinalizer(FREContext ctx)
{
	if (mouseHook != NULL)
	{
		UnhookWindowsHookEx(mouseHook);

		mouseHook = NULL;
	}

	return;
}

//------------------------------------------------------------------------------
//
//	Extension Initializer/Finalizer
//
//------------------------------------------------------------------------------

void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer)
{
	*ctxInitializer = &contextInitializer;
	*ctxFinalizer = &contextFinalizer;
}

void finalizer(void* extData)
{
	if (mouseHook != NULL)
	{
		UnhookWindowsHookEx(mouseHook);

		mouseHook = NULL;
	}

	return;
}
