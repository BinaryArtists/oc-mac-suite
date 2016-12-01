//
//  FileHelper.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

@singleton(FileHelper)

+ (BOOL)openDirectoryWithPath:(NSString *)path;

+ (void)closeDirectoryWithPath:(NSString *)path;

+ (NSData *)dataAtPath:(NSString *)path;

@end
