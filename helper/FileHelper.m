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

@end

@implementation FileHelper

@def_singleton(FileHelper)

+ (BOOL)openDirectoryWithPath:(NSString *)path {
    return YES;
}

+ (void)closeDirectoryWithPath:(NSString *)path {
    
}

+ (NSData *)dataAtPath:(NSString *)path {
    NSData *data = [[self sharedInstance].fileManager contentsAtPath:path];
    
    return data;
}

@end
