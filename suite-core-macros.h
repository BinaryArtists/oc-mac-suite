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

#ifdef DEBUG

#   define LOG( s, ... ) fprintf(stderr,"%s, %d, %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String]);

#else

#   define LOG( s, ... )

#endif

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

#define invalid_index -1

// Category import
// iOS中静态库(static library, .a文件)中的category变得可用 http://blog.csdn.net/skylin19840101/article/details/51821932
#define import_category( _class_name_ ) void import_##_class_name_##_compression();
#define def_import_category( _class_name_ ) void import_##_class_name_##_compression() {}
