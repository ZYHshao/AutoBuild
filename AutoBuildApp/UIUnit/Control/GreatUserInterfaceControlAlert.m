//
//  GreatUserInterfaceControlAlert.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/26.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "GreatUserInterfaceControlAlert.h"

@implementation GreatUserInterfaceControlAlert

+(void)alertInWiondow:(NSWindow *)window withTitle:(NSString *)title message:(NSString *)message callBack:(void(^)(int))callBack buttons:(NSString *)button, ...{
    NSAlert * alert = [[NSAlert alloc]init];
    [alert setMessageText:title];
    [alert setInformativeText:message];
    [alert setAlertStyle:NSAlertStyleWarning];
    va_list list;
    va_start(list, button);
    NSString * btn = button;
    while (btn!=nil) {
        [alert addButtonWithTitle:btn];
        btn = va_arg(list, NSString*);
    }
    va_end(list);//关闭列表指针
    [alert beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode==NSAlertFirstButtonReturn) {
            callBack(0);
        }
        if (returnCode==NSAlertSecondButtonReturn) {
            callBack(1);
        }
        if (returnCode==NSAlertThirdButtonReturn) {
            callBack(2);
        }
        callBack((int)returnCode);
    }];
}

@end
