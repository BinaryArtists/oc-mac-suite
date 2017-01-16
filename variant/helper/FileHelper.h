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

+ (BOOL)checkOrCreateDir:(NSString *)dir;

+ (BOOL)deleteFileAtPath:(NSString *)path;

+ (BOOL)deleteDirectoryAtPath:(NSString *)path;

+ (BOOL)clearDirectoryAtPath:(NSString *)Path;

+ (BOOL)copyfileAtPath:(NSString *)path to:(NSString *)destinationPath;

+ (BOOL)copyDirectoryAtPath:(NSString *)path to:(NSString *)destinationDirectory;

+ (NSData *)dataAtPath:(NSString *)path;

@end
