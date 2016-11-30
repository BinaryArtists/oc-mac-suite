//
//  BaseWindowController.m
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "BaseWindowController.h"

@interface BaseWindowController () <NSWindowDelegate> // 这种方法适用SDK 10.6 以上，因为SDK 10.5 还不支持 NSWindowDelegate 。

@end

@implementation BaseWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (void)windowWillClose:(NSNotification *)notification { // http://blog.csdn.net/perry_xiao/article/details/8738184
//    [NSApp stop:nil];
}

- (BOOL)windowShouldClose:(id)sender {
    [self showAlertWithTitle:@"考试还没有结束，是否确定离开考试？"
                     message:nil
                    onWindow:self.window
               defaultButton:@"是，直接交卷"
                defaultBlock:^{
                    [self stopApplication];
                }
           alternativeButton:@"否，继续答卷"
            alternativeBlock:^{
                
            }];

    return NO;
}

@end
