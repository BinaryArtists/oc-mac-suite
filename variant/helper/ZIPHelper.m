//
//  ZIPHelper.m
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "ZIPHelper.h"
#import "SSZipArchive.h"

@implementation ZIPHelper

+ (BOOL)zipAtPath:(NSString *)path with:(NSString *)directory {
    return [SSZipArchive createZipFileAtPath:path withContentsOfDirectory:directory];
}

+ (BOOL)unzipAtPath:(NSString *)path to:(NSString *)destination {
    return [SSZipArchive unzipFileAtPath:path toDestination:destination];
}

@end
