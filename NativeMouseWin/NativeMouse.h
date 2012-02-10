/*
 * SampleANE.h
 *
 *  Created on: Feb 10, 2012
 *      Author: mrozdobudko
 */

#include "FlashRuntimeExtensions.h"

#ifndef SAMPLEANE_H_
#define SAMPLEANE_H_

	__declspec(dllexport) void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);

	__declspec(dllexport) void finalizer(void* extData);

#endif /* SAMPLEANE_H_ */
