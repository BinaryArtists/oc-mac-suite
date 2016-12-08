//
//  core.m
//  core
//
//  Created by fallen.ink on 05/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "core.h"

/*
 最后一种解决方法是在只有category的源文件里添加Fakesymbol。如果你想在runtime里使用category，一定要确保你以某种方法在编译时引用了fake symbol，这会使得对象文件以及它里面的OC代码被载入。例如，它可以是一个有空函数体的函数，也可以是一个被访问的全局变量（例如一个全局的int变量，只要它被读或者写了一次就足够了）。和上面其他的解决方法不一样，这种解决方法可以控制哪些category可以在runtime里被编译后的代码使用（可以通过使用这个符号，使它们被链接并变得可用；也可以不使用这个符号，这样链接器就会忽略它）。
 */
//////////////////////////////////////////////////////////
// fallenink:这段要加在app target中，比如appDelegate中

#import "../foundation/extension/NSObject+Extension.h"
#import "../foundation/extension/NSString+Extension.h"

// iOS中静态库(static library, .a文件)中的category变得可用 http://blog.csdn.net/skylin19840101/article/details/51821932

__attribute__((used)) static void importCategories ()
{
    import_NSString_compression();
    import_NSObject_compression();
    // add more import calls here
}

//////////////////////////////////////////////////////////

@implementation core

@end
