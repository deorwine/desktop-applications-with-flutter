#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FLEFileSelectorPlugin.h"

FOUNDATION_EXPORT double file_selector_macosVersionNumber;
FOUNDATION_EXPORT const unsigned char file_selector_macosVersionString[];

