//
//  JSONHelper.m
//  exam
//
//  Created by fallen.ink on 29/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "JSONHelper.h"

@interface JSONHelper ()

@end

@implementation JSONHelper

@def_singleton(JSONHelper)

+ (NSDictionary *)jsonDictionaryFromFile:(NSString *)path {
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        loge(@"json string error = %@", error);
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        loge(@"json解析失败：%@", error);
        
        return nil;
    }
    
    return jsonDictionary;
}

+ (NSDictionary *)jsonDictionaryFromData:(NSData *)data {
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&error];
    if(error) {
        loge(@"json解析失败：%@", error);
        
        return nil;
    }
    
    return jsonDictionary;
}

@end
