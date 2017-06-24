//
//  AppDelegate.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "AppDelegate.h"
#import "RouteManager.h"

@interface AppDelegate ()<NSMenuDelegate>

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

//点击关闭按钮后 在dock上可以继续打开
- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    if (!flag){
        if (theApplication.windows.firstObject) {
            [[theApplication windows].firstObject makeKeyAndOrderFront:self];
        }
        return YES;
    }
    return NO;
    
}

#pragma mark -- menu tools action


/**
 添加工程

 @param sender item
 */
- (IBAction)addProject:(NSMenuItem *)sender {
    [[RouteManager defaultManager]presentAddProjectViewControllerWithVC:nil];
}


@end
