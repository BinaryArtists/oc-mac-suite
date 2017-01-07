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

+ (BOOL)deleteFileAtPath:(NSString *)path {
    return [[self sharedInstance].fileManager removeItemAtPath:path error:nil];
}

+ (BOOL)deleteDirectoryAtPath:(NSString *)path {
    [[self sharedInstance].fileManager removeItemAtPath:path error:nil];
    return YES;
}

+ (BOOL)clearDirectoryAtPath:(NSString *)Path {
    NSAssert(NO, @"");
    return YES;
}

+ (BOOL)copyfileAtPath:(NSString *)path to:(NSString *)destinationPath {
    NSAssert(NO, @"");
    return YES;
}

+ (BOOL)copyDirectoryAtPath:(NSString *)path to:(NSString *)destinationDirectory {
    NSAssert(NO, @"");
    return YES;
}

+ (NSData *)dataAtPath:(NSString *)path {
    NSData *data = [[self sharedInstance].fileManager contentsAtPath:path];
    
    return data;
}

@end
