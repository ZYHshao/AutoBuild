//
//  GreatUserInterfaceControlAlert.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/26.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface GreatUserInterfaceControlAlert : NSObject

+(void)alertInWiondow:(NSWindow *)window withTitle:(NSString *)title message:(NSString*)message callBack:(void(^)(int))callBack buttons:(NSString *)button,...NS_REQUIRES_NIL_TERMINATION;

@end
