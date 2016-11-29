//
//  SHSystem.m
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "SHSystem.h"

@implementation SHSystem

@def_singleton(SHSystem)

#pragma mark - functions

- (BOOL)openExtenalApplicationWithCommand:(NSString *)cmd {
    
    //直接运行
//    if(![[NSWorkspace sharedWorkspace] launchApplication:@"Path Finder"])
//        NSLog(@"运行失败");
//    ////////////////////////////////////////////////////////////
//    //带参数运行
//    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
//    NSURL *url = [NSURL fileURLWithPath:[workspace fullPathForApplication:@"Path Finder"]];
//    //Handle url==nil
//    NSError *error = nil;
//    NSArray *arguments = [NSArray arrayWithObjects:@"Argument1", @"Argument2", nil];
//    [workspace launchApplicationAtURL:url options:0 configuration:[NSDictionary dictionaryWithObject:arguments forKey:NSWorkspaceLaunchConfigurationArguments] error:error];
    
    return YES;
}

@end
