//
//  NSString+Extension.m
//  exam
//
//  Created by fallen.ink on 01/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)append:(NSString *)string {
    NSMutableString *aString = [self mutableCopy];
    
    [aString appendString:string];
    
    return aString;
}

- (BOOL)is:(NSString *)aString {
    return [self isEqualToString:aString];
}

+ (NSString *)random32 {
    char data[32];
    for (int x = 0; x < 32; data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

@end

def_import_category(NSString)
