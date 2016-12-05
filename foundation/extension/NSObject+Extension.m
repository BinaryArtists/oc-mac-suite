//
//  NSObject+Extension.m
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <AppKit/AppKit.h>

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

#pragma mark - 

- (void)stopApplication {
    [NSApp stop:nil];
}

@end
