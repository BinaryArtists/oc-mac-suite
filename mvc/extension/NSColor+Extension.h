//
//  NSColor+Extension.h
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIKit.h>
#define HXColor UIColor
#else
#import <Cocoa/Cocoa.h>
#define HXColor NSColor
#endif

@interface HXColor (Extension)

+ (nullable HXColor *)hx_colorWithHexRGBAString:(nonnull NSString *)hexString;

+ (nullable HXColor *)hx_colorWithHexRGBAString:(nonnull NSString *)hexString alpha:(CGFloat)alpha;

+ (nonnull HXColor *)hx_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

+ (nonnull HXColor *)hx_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

@end
