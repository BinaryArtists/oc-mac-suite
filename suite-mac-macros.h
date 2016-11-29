//
//  suite-mac-macros.h
//  exam
//
//  Created by fallen.ink on 29/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

// String

static inline BOOL is_empty(id thing) {
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

#define is_string_empty( _str_ )    is_empty( _str_ )

//

