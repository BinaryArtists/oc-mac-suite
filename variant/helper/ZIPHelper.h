//
//  ZIPHelper.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZIPHelper : NSObject

// 将文件夹directory，打包到path
+ (BOOL)zipAtPath:(NSString *)path with:(NSString *)directory;

// 将path的打包文件，解压到destination
+ (BOOL)unzipAtPath:(NSString *)path to:(NSString *)destination;

@end
