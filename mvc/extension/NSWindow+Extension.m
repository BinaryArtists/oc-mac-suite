//
//  NSWindow+Extension.m
//  exam
//
//  Created by fallen.ink on 15/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "NSWindow+Extension.h"

@implementation NSWindow (Extension)

#pragma mark - center

- (void)centerEx {
    [self centerWithSize:self.frame.size];
}

- (void)centerWithSize:(CGSize)size {
    NSWindow *window = self;
    
    CGRect screenRect = [[NSScreen mainScreen] frame];
    CGFloat x = (screenRect.size.width - size.width) / 2;
    CGFloat y = (screenRect.size.height - size.height) / 2;
    
    NSRect newFrame = NSMakeRect(x, y, size.width, size.height);
    
    [window setFrame:newFrame display:YES animate:NO];
}

#pragma mark -


@end
