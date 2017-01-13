//
//  NSImage+Extension.m
//  exam
//
//  Created by fallen.ink on 15/12/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import "NSImage+MVC.h"

@implementation NSImage (MVC)

- (NSImage *)resizeImageTosize:(NSSize)size {
    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
    NSImage *targetImage = [[NSImage alloc] initWithSize:size];
    
    NSSize sourceSize = [self size];
    
    float ratioH = size.height/ sourceSize.height;
    float ratioW = size.width / sourceSize.width;
    
    NSRect cropRect = NSZeroRect;
    
    if (ratioH >= ratioW) {
        cropRect.size.width = floor (size.width / ratioH);
        cropRect.size.height = sourceSize.height;
    } else {
        cropRect.size.width = sourceSize.width;
        cropRect.size.height = floor(size.height / ratioW);
    }
    
    cropRect.origin.x = floor( (sourceSize.width - cropRect.size.width)/2 );
    cropRect.origin.y = floor( (sourceSize.height - cropRect.size.height)/2 );
    
    [targetImage lockFocus];
    
    [self drawInRect:targetFrame
            fromRect:cropRect       //portion of source image to draw
           operation:NSCompositeCopy  //compositing operation
            fraction:1.0              //alpha (transparency) value
      respectFlipped:YES              //coordinate system
               hints:@{NSImageHintInterpolation:[NSNumber numberWithInt:NSImageInterpolationLow]}];
    
    [targetImage unlockFocus];
    
    return targetImage;
}

@end

def_import_category(NSImage_MVC)
