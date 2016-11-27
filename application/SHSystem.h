//
//  SHSystem.h
//  exam
//
//  Created by fallen.ink on 27/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHSystem : NSObject

@singleton(SHSystem)

// functions

- (BOOL)openExtenalApplicationWithCommand:(NSString *)cmd; // 打开外部app

@end
