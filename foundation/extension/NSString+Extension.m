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

@end

def_import_category(NSString)
