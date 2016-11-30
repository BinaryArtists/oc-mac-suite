//
//  NSWindowController+Extension.m
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "NSWindowController+Extension.h"

@implementation NSWindowController (Extension)

- (id) _initWithNib {
    return [self initWithWindowNibName:NSStringFromClass([self class])];
}

- (void)resizeWithNewFrame:(CGRect)newFrame {
    NSWindow *window = self.window;
    
    NSSize currentSize = window.frame.size;
    NSSize newSize = newFrame.size;
    
    CGFloat deltaWidth = newSize.width - currentSize.width;
    CGFloat deltaHeight = newSize.height - currentSize.height;
    
    NSRect windowFrame = [window frame];
    windowFrame.size.height += deltaHeight;
    windowFrame.size.width += deltaWidth;
    windowFrame.origin.y -= deltaHeight;
    
    [window setFrame:windowFrame display:YES animate:YES];
}

- (BOOL)shouldCloseDocument {
    return YES;
}

@end
