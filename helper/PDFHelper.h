//
//  PDFHelper.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFHelper : NSObject

@singleton(PDFHelper)

- (BOOL)openPDFWithPath:(NSString *)path;

- (void)closePDFWithPath:(NSString *)path;

@end
