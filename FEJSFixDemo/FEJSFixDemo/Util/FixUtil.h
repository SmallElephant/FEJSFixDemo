//
//  FixUtil.h
//  FEJSFixDemo
//
//  Created by FlyElephant on 2018/6/11.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, FixOptions) {
    FixPositionAfter   = 0,            /// Called after the original implementation (default)
    FixPositionInstead = 1,            /// Will replace the original implementation.
    FixPositionBefore  = 2,            /// Called before the original implementation.
};

@interface FixUtil : NSObject

+ (void)fix;
+ (void)runJavaScript:(NSString *)jsString;

@end

