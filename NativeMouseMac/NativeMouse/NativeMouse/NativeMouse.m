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

id globalMonitorId;

id localMonitorId;

NSEventMask FLAGS =  (NSLeftMouseDownMask | NSLeftMouseUpMask | NSRightMouseDownMask | NSRightMouseUpMask | NSMouseMovedMask | NSScrollWheelMask | NSLeftMouseDraggedMask);

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
//	Event Handler
//
//------------------------------------------------------------------------------

void mouseEventHandler(NSEvent *event)
{
    switch (event.type)
    {
        case NSMouseMoved:
            dispatchMouseEvent((const uint8_t*) "Mouse.Move");
            break;
        case NSLeftMouseDragged:
            dispatchMouseEvent((const uint8_t*) "Mouse.Move");
            break;
        case NSLeftMouseDown:
            dispatchMouseEvent((const uint8_t*) "Mouse.Down.LeftButton");
            break;
            
        case NSLeftMouseUp:
            dispatchMouseEvent((const uint8_t*) "Mouse.Up.LeftButton");
            break;
            
        case NSRightMouseDown:
            dispatchMouseEvent((const uint8_t*) "Mouse.Down.RightButton");
            break;
            
        case NSRightMouseUp:
            dispatchMouseEvent((const uint8_t*) "Mouse.Up.RightButton");
            break;
            
        case NSScrollWheel:
            dispatchMouseEvent((const uint8_t*) "Mouse.Wheel");
            break;
    }
}

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
    
    FRENewObjectFromBool((uint32_t) false, &result);
    
    if (globalMonitorId == NULL)
    {
        globalMonitorId =
        [NSEvent addGlobalMonitorForEventsMatchingMask: FLAGS handler:^(NSEvent* event) 
        {
            switch ([event type])
            {
                case NSMouseMoved:
                    FREDispatchStatusEventAsync(context, (const uint8_t*) "Mouse.Move", (const uint8_t *) "info");
                    break;
                case NSLeftMouseDragged:
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
    
    if (localMonitorId == NULL)
    {
        localMonitorId =
        [NSEvent addLocalMonitorForEventsMatchingMask: FLAGS handler:^NSEvent* (NSEvent* event)
         {
             switch ([event type])
             {
                 case NSMouseMoved:
                     FREDispatchStatusEventAsync(context, (const uint8_t*) "Mouse.Move", (const uint8_t *) "info");
                     break;
                 case NSLeftMouseDragged:
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
             
             return event;
         }];
    }
    
    return result;
}


FREObject releaseMouse(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromBool((uint32_t) false, &result);
    
    if (globalMonitorId != NULL)
    {
        [NSEvent removeMonitor:(globalMonitorId)];
        globalMonitorId = NULL;
        
        FRENewObjectFromBool((uint32_t) true, &result);
    }
    
    if (localMonitorId != NULL)
    {
        [NSEvent removeMonitor:(localMonitorId)];
        localMonitorId = NULL;
        
        FRENewObjectFromBool((uint32_t) true, &result);
    }
    
    return result;
}


FREObject getMouseInfo(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
{
    FREObject result = argv[0];
    
	NSPoint mouse = [NSEvent mouseLocation];
    
    NSArray* screens = [NSScreen screens];
    
    NSScreen* screen;
    
    NSUInteger count = [screens count];
    for (NSUInteger i = 0; i < count; i++)
    {
        NSScreen* s = [screens objectAtIndex: i];
        
        if (NSMouseInRect(mouse, [s frame], NO))
        {
            screen = s;
            continue;
        }
    }
    
    if (screen == NULL)
    {
        return result;
    }
    
    int32_t x = (int32_t) mouse.x;
	int32_t y = (int32_t) screen.frame.size.height - mouse.y;
    
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
    if (globalMonitorId != NULL)
    {
        [NSEvent removeMonitor:(globalMonitorId)];
        globalMonitorId = NULL;
    }
    
    if (localMonitorId != NULL)
    {
        [NSEvent removeMonitor:(localMonitorId)];
        localMonitorId = NULL;
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