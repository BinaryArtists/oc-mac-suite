//
//  SHSystem.m
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SHSystem.h"

@implementation SHSystem

@def_singleton(SHSystem)

#pragma mark - functions

- (BOOL)openApplicationWithAppName:(NSString *)appName, ... {
    NSMutableArray *arguments = [NSMutableArray new];
    
    va_list args;
    va_start(args, appName);
    
    if (is_string_empty(appName)) {
        return NO;
    }
    
    NSString *str;
        
    while (YES) {//在循环中遍历
        str = va_arg(args, NSString *);
        if (!str) {//当最后一个参数为nil的时候跳出循环
            break;
        } else {
            [arguments addObject:str];
        }
    }
    
    va_end(args);
    
    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
    
    if (!arguments.count) {
        // 无参数
        return [workspace launchApplication:appName];
    } else {
        NSURL *url = [NSURL fileURLWithPath:[workspace fullPathForApplication:appName]];
        return [workspace launchApplicationAtURL:url
                                         options:0
                                   configuration:[NSDictionary dictionaryWithObject:arguments forKey:NSWorkspaceLaunchConfigurationArguments]
                                           error:nil] != nil;
    }
}

- (BOOL)openFile:(NSString *)filepath {
    return [[NSWorkspace sharedWorkspace] openFile:filepath];
}

@end
