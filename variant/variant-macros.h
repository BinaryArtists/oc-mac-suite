//
//  suite-mac-macros.h
//  exam
//
//  Created by fallen.ink on 29/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

// Config
#if !defined (EXTERN)
#   if defined __cplusplus
#       define EXTERN extern "C"
#       define EXTERN_C_BEGIN extern "C" {
#       define EXTERN_C_END }
#   else
#       define EXTERN extern
#       define EXTERN_C_BEGIN
#       define EXTERN_C_END
#   endif
#endif

#ifndef	 TODO
#define TODO( X )			_Pragma(macro_cstr(message("TODO: " X)))
#endif

// ----------------------------------
// Meta macro
// ----------------------------------

#define macro_first(...)									macro_first_( __VA_ARGS__, 0 )
#define macro_first_( A, ... )								A

#define macro_concat( A, B )								macro_concat_( A, B )
#define macro_concat_( A, B )								A##B

#define macro_count(...)									macro_at( 8, __VA_ARGS__, 8, 7, 6, 5, 4, 3, 2, 1 )
#define macro_more(...)										macro_at( 8, __VA_ARGS__, 1, 1, 1, 1, 1, 1, 1, 1 )

#define macro_at0(...)										macro_first(__VA_ARGS__)
#define macro_at1(_0, ...)									macro_first(__VA_ARGS__)
#define macro_at2(_0, _1, ...)								macro_first(__VA_ARGS__)
#define macro_at3(_0, _1, _2, ...)							macro_first(__VA_ARGS__)
#define macro_at4(_0, _1, _2, _3, ...)						macro_first(__VA_ARGS__)
#define macro_at5(_0, _1, _2, _3, _4 ...)					macro_first(__VA_ARGS__)
#define macro_at6(_0, _1, _2, _3, _4, _5 ...)				macro_first(__VA_ARGS__)
#define macro_at7(_0, _1, _2, _3, _4, _5, _6 ...)			macro_first(__VA_ARGS__)
#define macro_at8(_0, _1, _2, _3, _4, _5, _6, _7, ...)		macro_first(__VA_ARGS__)
#define macro_at(N, ...)									macro_concat(macro_at, N)( __VA_ARGS__ )

#define macro_join0( ... )
#define macro_join1( A )									A
#define macro_join2( A, B )									A##____##B
#define macro_join3( A, B, C )								A##____##B##____##C
#define macro_join4( A, B, C, D )							A##____##B##____##C##____##D
#define macro_join5( A, B, C, D, E )						A##____##B##____##C##____##D##____##E
#define macro_join6( A, B, C, D, E, F )						A##____##B##____##C##____##D##____##E##____##F
#define macro_join7( A, B, C, D, E, F, G )					A##____##B##____##C##____##D##____##E##____##F##____##G
#define macro_join8( A, B, C, D, E, F, G, H )				A##____##B##____##C##____##D##____##E##____##F##____##G##____##H
#define macro_join( ... )									macro_concat(macro_join, macro_count(__VA_ARGS__))(__VA_ARGS__)

#define macro_cstr( A )										macro_cstr_( A )
#define macro_cstr_( A )									#A

#define macro_string( A )									macro_string_( A )
#define macro_string_( A )									@(#A)

// String

static inline BOOL is_empty(id thing) {
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

#define is_string_empty( _str_ )    is_empty( _str_ )

// inspired by https://github.com/ObornJung/OBFoundationLib/blob/master/OBFoundationLib/Macro/OBEncodeMacro.h
#define stringify(string)               @#string

#define string_of_obj( _obj_ )          [NSString stringWithFormat:@"%@", (NSObject *)_obj_]

/**
 *  字符串拼接
 *
 *  @param _str_
 *  @param _cat_
 *
 *  @return 拼接结果
 */
#define string_concat( _str_, _cat_ )    (_str_ _cat_)
#define string_concat_3( _str1_, _str2_, _str3_ ) (_str1_ _str2_ _str3_)

// Debug


// Types

typedef void(^Block)(void);
typedef void(^BlockBlock)(Block block);
typedef void(^BOOLBlock)(BOOL b);
typedef void(^ObjectBlock)(id obj);
typedef void(^ArrayBlock)(NSArray *array);
typedef void(^MutableArrayBlock)(NSMutableArray *array);
typedef void(^DictionaryBlock)(NSDictionary *dic);
typedef void(^ErrorBlock)(NSError *error);
typedef void(^IndexBlock)(NSInteger index);
typedef void(^ListItemBlock) (NSInteger index, id param);
typedef void(^FloatBlock)(CGFloat afloat);
typedef void(^StringBlock)(NSString *str);
typedef void(^ImageBlock)(NSImage *image);
typedef void(^ProgressBlock)(NSProgress *progress);

// Const

#define path_of_cache       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] // mac 下：/Users/lijie/Library/Caches
#define path_of_res         [[NSBundle mainBundle] resourcePath] // 这个不确定是否有写入权限

#define app_path_preview    @"/Applications/Preview.app"
#define app_path_xcode      @"/Applications/Xcode.app"

#define app_name 

#define invalid_index -1

// Category import
// iOS中静态库(static library, .a文件)中的category变得可用 http://blog.csdn.net/skylin19840101/article/details/51821932
#define import_category( _class_name_ ) void import_##_class_name_##_compression();
#define def_import_category( _class_name_ ) void import_##_class_name_##_compression() {}
