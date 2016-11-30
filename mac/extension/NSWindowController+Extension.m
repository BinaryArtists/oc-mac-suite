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

@end
