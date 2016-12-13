//
//  FileHelper.m
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "FileHelper.h"

@interface FileHelper ()

@property (nonatomic, strong) NSFileManager *fileManager;

@singleton(FileHelper)

@end

@implementation FileHelper

@def_singleton(FileHelper)

#pragma mark -

- (instancetype)init {
    if (self = [super init]) {
        self.fileManager = [NSFileManager defaultManager];
    }
    
    return self;
}

#pragma mark -


+ (BOOL)openDirectoryWithPath:(NSString *)path {
    return YES;
}

+ (void)closeDirectoryWithPath:(NSString *)path {
    
}

+ (BOOL)checkOrCreateDir:(NSString *)dir {
    BOOL isDir = NO;
    BOOL isFileExist = [[self sharedInstance].fileManager fileExistsAtPath:dir isDirectory:&isDir];
    if (isFileExist && isDir) return YES;
    
    if (isFileExist && !isDir) {
        [[self sharedInstance].fileManager removeItemAtPath:dir error:nil];
        
        [[self sharedInstance].fileManager createDirectoryAtPath:dir
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:nil];
    }
    
    if (!isFileExist) {
        [[self sharedInstance].fileManager createDirectoryAtPath:dir
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:nil];
    }
    
    return NO;
}

+ (NSData *)dataAtPath:(NSString *)path {
    NSData *data = [[self sharedInstance].fileManager contentsAtPath:path];
    
    return data;
}

@end
