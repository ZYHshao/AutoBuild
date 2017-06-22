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


#pragma mark -- menu tools action


/**
 添加工程

 @param sender item
 */
- (IBAction)addProject:(NSMenuItem *)sender {
    [[RouteManager defaultManager]presentAddProjectViewControllerWithVC:nil];
}


@end
