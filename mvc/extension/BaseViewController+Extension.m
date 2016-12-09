//
//  BaseViewController+Extension.m
//  exam
//
//  Created by fallen.ink on 09/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "BaseViewController+Extension.h"

@implementation BaseViewController (Extension)

- (instancetype)_initWithNibWithWindowController:(id)windowController {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil windowController:windowController];
}

@end
