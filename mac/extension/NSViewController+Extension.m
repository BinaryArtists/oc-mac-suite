//
//  NSViewController+Extension.m
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "NSViewController+Extension.h"

@implementation NSViewController (Extension)

- (id) _initWithNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
