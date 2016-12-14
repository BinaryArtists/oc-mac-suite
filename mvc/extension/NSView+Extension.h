//
//  NSView+Extension.h
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/** Coordinate types for a given view object. */
typedef NS_ENUM(NSUInteger, NSViewCornerCoordinateType) {
    NSViewCornerCoordinateTypeTopLeft = 0,
    NSViewCornerCoordinateTypeTopRight,
    NSViewCornerCoordinateTypeBottomLeft,
    NSViewCornerCoordinateTypeBottomRight,
};

@interface NSView (Extension)

/** Sets the origin.x property of the view to left. */
@property (nonatomic, assign) CGFloat left;

/** Sets the origin.x property of the view to 'right - self.frame.size.width'. */
@property (nonatomic, assign) CGFloat right;

/** Sets the origin.y property of the view to 'top - self.frame.size.height'. */
@property (nonatomic, assign) CGFloat top;

/** Sets the origin.y property of the view to 'bottom'. */
@property (nonatomic, assign) CGFloat bottom;

/** Sets the size.width property of the view to width. */
@property (nonatomic, assign) CGFloat width;

/** Sets the size.height property of the view to height. */
@property (nonatomic, assign) CGFloat height;

/** Sets the size property of the view to 'size'. */
@property (nonatomic, assign) CGSize size;

/** Sets the center property of the view to 'center'. */
@property (nonatomic, assign) CGPoint center;

/** Returns the corner coordinate as a CGPoint for a given corner type. See 'NSViewCornerCoordinateType' */
- (NSPoint)cornerCoordinateForType:(NSViewCornerCoordinateType)cornerType;

- (void)setBorderWithDepth:(CGFloat)depth color:(NSColor *)color;

- (void)setBackgroundColor:(NSColor *)color;

@end

#pragma mark - Nib loadable view
// refer to https://github.com/inspace-io/INSNibLoading

@interface NSView (INSNibLoading)

// Convenience method, loads a nib named after the class name.
- (void)ins_loadContentsFromNib;

@end

// Convenience NSView subclass.
//
// Custom NSViews can simply subclass INSNibLoadedView.
// It calls ins_loadContentsFromNib in its initializer.
//
// If you need to subclass another NSView subclass (e.g. a custom UIControl),
// you'll need to call ins_loadContentsFromNib yourself.
//
//  Remember: set file's owner 'CustomView' not the View, and link the Outlets.
//
@interface NSNibLoadableView : NSView
@end
