//
//  suite-app-macros.h
//  exam
//
//  Created by fallen.ink on 15/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

// image

#define imagenamed(_ptr_)   [NSImage imageNamed:_ptr_];

// font
#define FONT_L                      [NSFont systemFontOfSize:18] // ...
#define FONT_M                      [NSFont systemFontOfSize:15] // TITLE
#define FONT_S                      [NSFont systemFontOfSize:12] // CONTENT

// size
// [约束]一排两个按钮: width 72, height 21
// [约束]一排一个按钮: width 96, height 21

#define def_window_size(_width_, _height_) static const CGSize _windowSize = {.width = _width_, .height = _height_}; // use as fixed size variable
