//
//  NSView+Extension.m
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "NSView+Extension.h"

@implementation NSView (Extension)

- (void)setBorderWithDepth:(CGFloat)depth color:(NSColor *)color {
    self.layer.borderWidth = depth;
    self.layer.borderColor = color.CGColor;
}

@end
