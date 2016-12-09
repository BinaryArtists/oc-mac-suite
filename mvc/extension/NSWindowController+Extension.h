//
//  NSWindowController+Extension.h
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSWindowController (Extension)

- (id) _initWithNib;

- (void)resizeWithNewFrame:(CGRect)newFrame;

// Transition

- (void)fadeTransitionTo:(NSWindowController *)windowController; // [淡出] windowController must be a retained object!!!

@end
