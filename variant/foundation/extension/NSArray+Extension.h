//
//  NSArray+Extension.h
//  core
//
//  Created by fallen.ink on 21/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

// ----------------------------------
// NSArray's category
// ----------------------------------

@interface NSArray (Extension)

- (id)safeObjectAtIndex:(NSUInteger)index;
- (id)safeSubarrayWithRange:(NSRange)range;
- (id)safeSubarrayFromIndex:(NSUInteger)index;
- (id)safeSubarrayWithCount:(NSUInteger)count;

// 鉴于containsObject:是比较对象：调用isEqual:，该方法比较的是hash值，所以添加如下方法
// 该方法常用于判断 dictionary 的key存在性
- (BOOL)containsString:(NSString *)aString;

@end

// ----------------------------------
// NSMutableArray's category
// ----------------------------------

@interface NSMutableArray (Extension)

- (void)addObjectIfNotNil:(id)anObject;
- (BOOL)addObjectsFromArrayIfNotNil:(NSArray *)otherArray;

@end

import_category(NSArray)
