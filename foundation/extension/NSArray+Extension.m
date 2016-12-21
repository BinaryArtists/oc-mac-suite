//
//  NSArray+Extension.m
//  core
//
//  Created by fallen.ink on 21/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "NSArray+Extension.h"

// ----------------------------------
// NSArray's category
// ----------------------------------

@implementation NSArray (Extension)

- (id)safeObjectAtIndex:(NSUInteger)index {
    if ( index >= self.count )
        return nil;
    
    return [self objectAtIndex:index];
}

- (id)safeSubarrayWithRange:(NSRange)range {
    if ( 0 == self.count )
        return [NSArray array];
    
    if ( range.location >= self.count )
        return [NSArray array];
    
    range.length = MIN( range.length, self.count - range.location );
    if ( 0 == range.length )
        return [NSArray array];
    
    return [self subarrayWithRange:NSMakeRange(range.location, range.length)];
}

- (id)safeSubarrayFromIndex:(NSUInteger)index {
    if ( 0 == self.count )
        return [NSArray array];
    
    if ( index >= self.count )
        return [NSArray array];
    
    return [self safeSubarrayWithRange:NSMakeRange(index, self.count - index)];
}

- (id)safeSubarrayWithCount:(NSUInteger)count {
    if ( 0 == self.count )
        return [NSArray array];
    
    return [self safeSubarrayWithRange:NSMakeRange(0, count)];
}

#pragma mark - 

- (BOOL)containsString:(NSString *)aString {
    __block BOOL contained = NO;
    
    [self enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            // 如果有非String对象，返回
            *stop = YES;
        }
        
        if ([obj isEqualToString:aString]) {
            contained = YES;
            *stop = YES;
        }
    }];
    
    return contained;
}

@end

// ----------------------------------
// NSMutableArray's category
// ----------------------------------

@implementation NSMutableArray (Extension)

- (void)addObjectIfNotNil:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

- (BOOL)addObjectsFromArrayIfNotNil:(NSArray *)otherArray {
    if (!is_empty(otherArray) && [otherArray isKindOfClass:[NSArray class]]) {
        [self addObjectsFromArray:otherArray];
        return YES;
    }
    return NO;
}

@end

def_import_category(NSArray)
