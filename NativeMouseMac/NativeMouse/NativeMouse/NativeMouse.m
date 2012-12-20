//
//  NativeMouse.m
//  NativeMouse
//
//  Created by Max Rozdobudko on 17.12.12.
//  Copyright (c) 2012 Max Rozdobudko. All rights reserved.
//

#import "NativeMouse.h"

//------------------------------------------------------------------------------
//
//	Variables
//
//------------------------------------------------------------------------------

FREContext context;

id monitorId;

//------------------------------------------------------------------------
//
//  API
//
//------------------------------------------------------------------------

FREObject isSupported(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    uint32_t isUpportedInThisOS = 1;
    
    FRENewObjectFromBool(isUpportedInThisOS, &result);
    
    return result;
}


FREObject captureMouse(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    if (monitorId == NULL)
    {
        monitorId =
        [NSEvent addGlobalMonitorForEventsMatchingMask:
         (NSLeftMouseDownMask | NSLeftMouseUpMask | NSRightMouseDownMask | NSRightMouseUpMask | NSMouseMovedMask | NSScrollWheelMask)
            handler:^(NSEvent* incomingEvent)
        {
            switch ([incomingEvent type])
            {
                case NSMouseMoved:
                    FREDispatchStatusEventAsync(context, (const uint8_t*) "Mouse.Move", (const uint8_t *) "info");
                    break;
                    
                case NSLeftMouseDown:
                    FREDispatchStatusEventAsync(context, (const uint8_t*) "Mouse.Down.LeftButton", (const uint8_t *) "info");
                    break;
                    
                case NSLeftMouseUp:
                    FREDispatchStatusEventAsync(context, (const uint8_t*) "Mouse.Up.LeftButton", (const uint8_t *) "info");
                    break;
                    
                case NSRightMouseDown:
                    FREDispatchStatusEventAsync(context, (const uint8_t*) "Mouse.Down.RightButton", (const uint8_t *) "info");
                    break;
                    
                case NSRightMouseUp:
                    FREDispatchStatusEventAsync(context, (const uint8_t*) "Mouse.Up.RightButton", (const uint8_t *) "info");
                    break;
                    
                case NSScrollWheel:
                    FREDispatchStatusEventAsync(context, (const uint8_t*) "Mouse.Wheel", (const uint8_t *) "info");
                    break;
            }
        }];
        
        FRENewObjectFromBool((uint32_t) true, &result);
    }
    else
    {
        FRENewObjectFromBool((uint32_t) false, &result);
    }
    
    return result;
}


FREObject releaseMouse(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    if (monitorId != NULL)
    {
        [NSEvent removeMonitor:(monitorId)];
        monitorId = NULL;
        
        FRENewObjectFromBool((uint32_t) true, &result);
    }
    else
    {
        FRENewObjectFromBool((uint32_t) false, &result);
    }
    
    return result;
}


FREObject getMouseInfo(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
{
    FREObject result = argv[0];
    
    NSLog(@"getMouseInfo()");
    
	NSPoint mouse = [NSEvent mouseLocation];
    
    int32_t x = (int32_t) mouse.x;
	int32_t y = (int32_t) mouse.y;
    
	FREObject mouseX;
	FREObject mouseY;
    
	FRENewObjectFromInt32(x, &mouseX);
	FRENewObjectFromInt32(y, &mouseY);
    
	FRESetObjectProperty(result, (const uint8_t*) "mouseX", mouseX, NULL);
	FRESetObjectProperty(result, (const uint8_t*) "mouseY", mouseY, NULL);
    
    
    uint32_t isUpportedInThisOS = 1;
    
    FRENewObjectFromBool(isUpportedInThisOS, &result);
    
    return result;
}

//------------------------------------------------------------------------
//
//  Context Initializer/Finalizer
//
//------------------------------------------------------------------------

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
    *numFunctions = 4;
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &isSupported;
    
    func[1].name = (const uint8_t*) "captureMouse";
    func[1].functionData = NULL;
    func[1].function = &captureMouse;
    
    func[2].name = (const uint8_t*) "releaseMouse";
    func[2].functionData = NULL;
    func[2].function = &releaseMouse;
    
    func[3].name = (const uint8_t*) "getMouseInfo";
    func[3].functionData = NULL;
    func[3].function = &getMouseInfo;
    
    *functions = func;
    
    context = ctx;
}

void contextFinalizer(FREContext ctx)
{
    if (monitorId != NULL)
    {
        [NSEvent removeMonitor:(monitorId)];
        monitorId = NULL;
    }
    
    context = NULL;
}

//------------------------------------------------------------------------
//
//  External
//
//------------------------------------------------------------------------

void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer)
{
    *ctxInitializer = &contextInitializer;
    *ctxFinalizer = &contextFinalizer;
}

void finalizer(void *extData)
{
    return;
}