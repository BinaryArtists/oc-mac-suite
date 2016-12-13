//
//  FileHelper.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "suite-core.h"

@interface FileHelper : NSObject

+ (BOOL)openDirectoryWithPath:(NSString *)path;

+ (void)closeDirectoryWithPath:(NSString *)path;

+ (BOOL)checkOrCreateDir:(NSString *)dir;

+ (NSData *)dataAtPath:(NSString *)path;

@end
