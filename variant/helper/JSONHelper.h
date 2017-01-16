//
//  JSONHelper.h
//  exam
//
//  Created by fallen.ink on 29/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//
//  弱于JSONModel的一个json操作辅助类

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

@singleton(JSONHelper)

+ (NSDictionary *)jsonDictionaryFromFile:(NSString *)path;

+ (NSDictionary *)jsonDictionaryFromData:(NSData *)data;

@end
