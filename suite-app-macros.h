//
//  suite-app-macros.h
//  exam
//
//  Created by fallen.ink on 15/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

// image

#define imagenamed(_ptr_)   [NSImage imageNamed:_ptr_];

// pixel
#define PIXEL_1                     1.f
#define PIXEL_2                     2.f
#define PIXEL_4                     4.f
#define PIXEL_6                     6.f
#define PIXEL_8                     8.f
#define PIXEL_10                    10.f
#define PIXEL_12                    12.f
#define PIXEL_16                    16.f
#define PIXEL_18                    18.f
#define PIXEL_30                    30.f
#define PIXEL_40                    40.f
#define PIXEL_44                    44.f
#define PIXEL_64                    64.f

// font
#define FONT_L                      [NSFont systemFontOfSize:18] // ...
#define FONT_M                      [NSFont systemFontOfSize:15] // TITLE
#define FONT_S                      [NSFont systemFontOfSize:12] // CONTENT

#define screen_width                [NSScreen mainScreen].frame.size.width
#define screen_height               [NSScreen mainScreen].frame.size.height

// size
// [约束]一排两个按钮: width 72, height 21
// [约束]一排一个按钮: width 96, height 21

#define def_window_size(_width_, _height_) __unused static const CGSize _windowSize = {.width = _width_, .height = _height_}; // use as fixed size variable
