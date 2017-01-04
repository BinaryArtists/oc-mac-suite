//
//  NSImage+Extension.m
//  core
//
//  Created by fallen.ink on 04/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import "NSImage+Extension.h"

@implementation NSImage (Extension)

+ (NSImage *)imageWithFilepath:(NSString *)filepath {
    NSURL *fileurl = [NSURL URLWithString:filepath];
    return [[NSImage alloc] initWithContentsOfURL:fileurl];
}

@end

def_import_category(NSImage)
