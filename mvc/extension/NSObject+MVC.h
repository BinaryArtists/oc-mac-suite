//
//  NSObject+MVC.h
//  exam
//
//  Created by fallen.ink on 30/11/2016.
//  Copyright © 2016 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MVC)

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                  onWindow:(NSWindow *)window
             defaultButton:(NSString *)defaultText
              defaultBlock:(Block)defaultHandler // 右侧按钮
         alternativeButton:(NSString *)alternativeText
          alternativeBlock:(Block)alternativeHandler; // 左侧按钮

@end
