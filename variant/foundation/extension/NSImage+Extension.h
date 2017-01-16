//
//  NSImage+Extension.h
//  core
//
//  Created by fallen.ink on 04/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Extension)

+ (NSImage *)imageWithFilepath:(NSString *)filepath;

@end

import_category(NSImage)
