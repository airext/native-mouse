//
//  NativeMouse.h
//  NativeMouse
//
//  Created by Max Rozdobudko on 17.12.12.
//  Copyright (c) 2012 Max Rozdobudko. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <Adobe AIR/Adobe AIR.h>

#define EXPORT __attribute__((visibility("default")))

FREObject isSupported(FREContext context, void *data, uint32_t, FREObject args[]);

FREObject captureMouse(FREContext context, void *data, uint32_t, FREObject args[]);

FREObject releaseMouse(FREContext context, void *data, uint32_t, FREObject args[]);

FREObject getMouse(FREContext context, void *data, uint32_t, FREObject args[]);

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions);

void contextFinalizer(FREContext ctx);

EXPORT
void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);

EXPORT
void finalizer(void* extData);