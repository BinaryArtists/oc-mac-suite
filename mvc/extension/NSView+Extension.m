//
//  NSView+Extension.m
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "NSView+Extension.h"
#import <objc/runtime.h>

def_import_category(NSView)

@implementation NSView (Extension)

// ------------------------------------------------------------------------------------------
#pragma mark - Left, Right, Top, Bottom
// ------------------------------------------------------------------------------------------
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    NSRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    NSRect rect = self.frame;
    rect.origin.x = right - rect.size.width;
    self.frame = rect;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    NSRect rect = self.frame;
    rect.origin.y = top - rect.size.height;
    self.frame = rect;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    NSRect rect = self.frame;
    rect.origin.y = bottom;
    self.frame = rect;
}

// ------------------------------------------------------------------------------------------
#pragma mark - Width, Height, Size, Center
// ------------------------------------------------------------------------------------------
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    NSRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    NSRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    NSRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (NSPoint)center {
    CGFloat centerX = self.frame.origin.x + (self.frame.size.width / 2.0);
    CGFloat centerY = self.frame.origin.y + (self.frame.size.height / 2.0);
    
    return CGPointMake(centerX, centerY);
}

- (void)setCenter:(CGPoint)center {
    CGFloat originX = center.x - (self.frame.size.width / 2.0);
    CGFloat originY = center.y - (self.frame.size.height / 2.0);
    
    self.frame = NSMakeRect(originX, originY, self.frame.size.width, self.frame.size.height);
}

// ------------------------------------------------------------------------------------------
#pragma mark -
// ------------------------------------------------------------------------------------------

- (void)removeAllSubViews {
    NSView *realView = self;
    
//    if ([self isKindOfClass:NSScrollView.class]) {
//        realView = ((NSScrollView *)self).documentView;
//    }
//    
    [realView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)setFocused:(BOOL)focused {
    // 这里有个bug，当设置过的window离开焦点时，会crash
    if (self.acceptsFirstResponder) {
        [self.window makeFirstResponder:self];
    }
}

// ------------------------------------------------------------------------------------------
#pragma mark - Corner Coordinate
// ------------------------------------------------------------------------------------------
- (NSPoint)cornerCoordinateForType:(NSViewCornerCoordinateType)cornerType {
    switch (cornerType) {
        case NSViewCornerCoordinateTypeTopLeft: {
            return NSMakePoint(self.bounds.origin.x, self.bounds.size.height);
        }
        case NSViewCornerCoordinateTypeTopRight: {
            return NSMakePoint(self.bounds.size.width, self.bounds.size.height);
        }
        case NSViewCornerCoordinateTypeBottomLeft: {
            return NSMakePoint(self.bounds.origin.x, self.bounds.origin.y);
        }
        case NSViewCornerCoordinateTypeBottomRight: {
            return NSMakePoint(self.bounds.size.width, self.bounds.origin.y);
        }
        default: {
            return NSZeroPoint;
        }
    }
}

#pragma mark -

- (void)enableBackgroundLayer {
    if (!self.wantsLayer) {
        CALayer *backgroundLayer = [CALayer layer];
        [self setWantsLayer:YES];
        [self setLayer:backgroundLayer];
    }
}

- (void)setBorderWithDepth:(CGFloat)depth color:(NSColor *)color {
    [self enableBackgroundLayer];
    
    self.layer.borderWidth = depth;
    self.layer.borderColor = color.CGColor;
}

- (void)setBackgroundColor:(NSColor *)color {
    [self enableBackgroundLayer];
    
    [self.layer setBackgroundColor:color.CGColor];
}

- (void)circular:(CGFloat)radius {
    [self enableBackgroundLayer];

    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

@end

#pragma mark - INSNibLoadedView

static char INSNibLoadingAssociatedNibsKey;
static char INSNibLoadingOutletsKey;

@implementation NSView (INSNibLoading)

+ (NSNib *)ins_nibLoadingAssociatedNibWithName:(NSString *)nibName bundle:(NSBundle *)bundle {
    
    NSDictionary *associatedNibs = objc_getAssociatedObject(self, &INSNibLoadingAssociatedNibsKey);
    NSNib *nib = associatedNibs[nibName];
    if (!nib) {
        nib = [[NSNib alloc] initWithNibNamed:nibName bundle:bundle];
        if (nib) {
            NSMutableDictionary *newNibs = [NSMutableDictionary dictionaryWithDictionary:associatedNibs];
            newNibs[nibName] = nib;
            objc_setAssociatedObject(self, &INSNibLoadingAssociatedNibsKey, [NSDictionary dictionaryWithDictionary:newNibs], OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    return nib;
}

- (NSView *)ins_contentViewForNib {
    return self;
}

- (void)ins_loadContentsFromNibNamed:(NSString *)nibName bundle:(NSBundle *)bundle {
    // Load the nib file, setting self as the owner.
    // The root view is only a container and is discarded after loading.
    NSNib *nib = [[self class] ins_nibLoadingAssociatedNibWithName:nibName bundle:bundle];
    NSAssert(nib != nil, @"NSView+INSNibLoading : Can't load nib named %@.", nibName);
    
    // Instantiate (and keep a list of the outlets set through KVC.)
    NSMutableDictionary *outlets = [NSMutableDictionary new];
    objc_setAssociatedObject(self, &INSNibLoadingOutletsKey, outlets, OBJC_ASSOCIATION_RETAIN);
    
    NSArray *views = nil;
    [nib instantiateWithOwner:self topLevelObjects:&views];
    NSAssert(views != nil, @"NSView+INSNibLoading : Can't instantiate nib named %@.", nibName);
    
    objc_setAssociatedObject(self, &INSNibLoadingOutletsKey, nil, OBJC_ASSOCIATION_RETAIN);
    
    // Search for the first encountered UIView base object
    NSView *containerView = nil;
    for (id v in views) {
        if ([v isKindOfClass:[NSView class]]) {
            containerView = v;
            break;
        }
    }
    NSAssert(containerView != nil, @"NSView+INSNibLoading : There is no container UIView found at the root of nib %@.", nibName);
    
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    if (CGRectEqualToRect(self.bounds, CGRectZero)) {
        // `self` has no size : use the containerView's size, from the nib file
        self.bounds = containerView.bounds;
    } else {
        // `self` has a specific size : resize the containerView to this size, so that the subviews are autoresized.
        containerView.bounds = self.bounds;
    }
    
    // Save constraints for later
    NSArray *constraints = containerView.constraints;
    
    // reparent the subviews from the nib file
    for (NSView *view in containerView.subviews) {
        if (view.superview) {
            [view removeFromSuperview];
        }
        [[self ins_contentViewForNib] addSubview:view];
    }
    
    // Recreate constraints, replace containerView with self
    for (NSLayoutConstraint *oldConstraint in constraints) {
        id firstItem = oldConstraint.firstItem;
        id secondItem = oldConstraint.secondItem;
        if (firstItem == containerView) {
            firstItem = [self ins_contentViewForNib];
        }
        if (secondItem == containerView) {
            secondItem = [self ins_contentViewForNib];
        }
        
        NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                         attribute:oldConstraint.firstAttribute
                                                                         relatedBy:oldConstraint.relation
                                                                            toItem:secondItem
                                                                         attribute:oldConstraint.secondAttribute
                                                                        multiplier:oldConstraint.multiplier
                                                                          constant:oldConstraint.constant];
        [self addConstraint:newConstraint];
        
        // If there was outlet(s) to the old constraint, replace it with the new constraint.
        for (NSString *key in outlets) {
            if (outlets[key] == oldConstraint) {
                NSAssert([self valueForKey:key] == oldConstraint, @"NSView+INSNibLoading : Unexpected value for outlet %@ of view %@. Expected %@, found %@.", key, self, oldConstraint, [self valueForKey:key]);
                [self setValue:newConstraint forKey:key];
            }
        }
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    // Keep a list of the outlets set during nib loading.
    // (See above: This associated object only exists during nib-loading)
    NSMutableDictionary *outlets = objc_getAssociatedObject(self, &INSNibLoadingOutletsKey);
    outlets[key] = value;
    [super setValue:value forKey:key];
}

- (void)ins_loadContentsFromNibNamed:(NSString *)nibName {
    [self ins_loadContentsFromNibNamed:nibName bundle:[NSBundle bundleForClass:[self class]]];
}

- (void)ins_loadContentsFromNib {
    NSString *className = NSStringFromClass([self class]);
    
    // A Swift class name will be in the format of ModuleName.ClassName
    // We want to remove the module name so the Nib can have exactly the same file name as the class
    NSRange range = [className rangeOfString:@"."];
    if (range.location != NSNotFound) {
        className = [className substringFromIndex:range.location + range.length];
    }
    [self ins_loadContentsFromNibNamed:className];
}

@end

@implementation NSNibLoadableView : NSView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self ins_loadContentsFromNib];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self ins_loadContentsFromNib];
    }
    
    return self;
}

@end

#pragma mark - Transition

@implementation NSView ( Transition )

+ (void)transitionFromView:(NSView *)fromView
                    toView:(NSView *)toView
     withZoomingTransition:(NSViewTransition)transition
                  duration:(CGFloat)duration
         completionHandler:(void (^)(void))completionHandler {
    if (fromView == nil || toView == nil) {
        if (completionHandler)
            completionHandler();
        return;
    }
    
    BOOL wantsLayer = fromView.superview.wantsLayer;
    fromView.superview.wantsLayer = YES;
    toView.frame = fromView.frame;
    
    //create an image of the view we're transitioning to
    NSBitmapImageRep *rep = [toView bitmapImageRepForCachingDisplayInRect:toView.bounds];
    [toView cacheDisplayInRect:toView.bounds toBitmapImageRep:rep];
    NSImage *toImage = [[NSImage alloc] initWithSize:rep.size];
    [toImage addRepresentation:rep];
    
    NSRect initialToRect = NSZeroRect;
    CGFloat widthDiff = (fromView.superview.frame.size.width/20.0);
    CGFloat heightDiff = (fromView.superview.frame.size.height/20.0);
    if (transition == NSViewTransitionZoomOut)
        initialToRect = NSMakeRect(-widthDiff,
                                   -heightDiff,
                                   fromView.superview.frame.size.width+(widthDiff*2),
                                   fromView.superview.frame.size.height+(heightDiff*2));
    else if (transition == NSViewTransitionZoomIn)
        initialToRect = NSMakeRect(widthDiff,
                                   heightDiff,
                                   fromView.superview.frame.size.width-(widthDiff*2),
                                   fromView.superview.frame.size.height-(heightDiff*2));
    
    NSImageView *toImageView = [[NSImageView alloc] initWithFrame:initialToRect];
    toImageView.wantsLayer = YES;
    toImageView.image = toImage;
    toImageView.imageAlignment = NSImageAlignCenter;
    toImageView.imageScaling = NSImageScaleAxesIndependently;
    toImageView.editable = NO;
    toImageView.animates = NO;
    toImageView.allowsCutCopyPaste = NO;
    toImageView.imageFrameStyle = NSImageFrameNone;
    toImageView.alphaValue = 0.0;
    
    toView.alphaValue = 0.0;
    [fromView.superview addSubview:toView];
    
    //create an image of the view we're transitioning from
    rep = [fromView bitmapImageRepForCachingDisplayInRect:fromView.bounds];
    [fromView cacheDisplayInRect:fromView.bounds toBitmapImageRep:rep];
    NSImage *fromImage = [[NSImage alloc] initWithSize:rep.size];
    [fromImage addRepresentation:rep];
    
    NSImageView *fromImageView = [[NSImageView alloc] initWithFrame:fromView.frame];
    fromImageView.wantsLayer = YES;
    fromImageView.image = fromImage;
    fromImageView.imageAlignment = NSImageAlignCenter;
    fromImageView.imageScaling = NSImageScaleAxesIndependently;
    fromImageView.editable = NO;
    fromImageView.animates = NO;
    fromImageView.allowsCutCopyPaste = NO;
    fromImageView.imageFrameStyle = NSImageFrameNone;
    
    [fromView.superview addSubview:fromImageView positioned:NSWindowAbove relativeTo:nil];
    [fromView.superview addSubview:toImageView positioned:NSWindowAbove relativeTo:nil];
    [fromView removeFromSuperview];
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = duration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        fromImageView.animator.alphaValue = 0.0;
        NSRect zoomRect = NSZeroRect;
        if (transition == NSViewTransitionZoomOut)
            zoomRect = NSMakeRect(widthDiff,
                                  heightDiff,
                                  fromImageView.frame.size.width-(widthDiff*2),
                                  fromImageView.frame.size.height-(heightDiff*2));
        else if (transition == NSViewTransitionZoomIn)
            zoomRect = NSMakeRect(-widthDiff,
                                  -heightDiff,
                                  fromImageView.frame.size.width+(widthDiff*2),
                                  fromImageView.frame.size.height+(heightDiff*2));
        fromImageView.animator.frame = zoomRect;
        
        toImageView.animator.alphaValue = 1.0;
        toImageView.animator.frame = fromImageView.superview.frame;
    }
                        completionHandler:^{
                            toView.alphaValue = 1.0;
                            [fromImageView.superview addSubview:toView positioned:NSWindowAbove relativeTo:nil];
                            [fromImageView removeFromSuperview];
                            [toImageView removeFromSuperview];
                            [fromView removeFromSuperview];
                            fromView.superview.wantsLayer = wantsLayer;
                            
                            if (completionHandler)
                                completionHandler();
                        }];
}

- (void)transitionToView:(NSView *)toView
   withZoomingTransition:(NSViewTransition)transition
                duration:(CGFloat)duration
       completionHandler:(void (^)(void))completionHandler {
    [[self class] transitionFromView:self
                              toView:toView
               withZoomingTransition:transition
                            duration:duration
                   completionHandler:completionHandler];
}

@end
