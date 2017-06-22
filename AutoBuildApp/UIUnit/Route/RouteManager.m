//
//  RouteManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "RouteManager.h"
#import "AddProjectViewController.h"

@interface RouteManager()

@property(nonatomic,strong)AddProjectViewController * addProjectViewControllerRef;

@end

@implementation RouteManager

+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static RouteManager * manager = nil;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[RouteManager alloc]init];
        }
    });
    return manager;
}

-(void)presentAddProjectViewControllerWithVC:(NSViewController *)controller{
    [self.addProjectViewControllerRef clearUI];
    if (controller) {
        [controller presentViewControllerAsModalWindow:self.addProjectViewControllerRef];
    }else{
        [[NSApplication sharedApplication].keyWindow.contentViewController presentViewControllerAsModalWindow:self.addProjectViewControllerRef];
    }
}

#pragma mark -- setter and getter
-(AddProjectViewController *)addProjectViewControllerRef{
    if (!_addProjectViewControllerRef) {
        _addProjectViewControllerRef = [[AddProjectViewController alloc]init];
    }
    return _addProjectViewControllerRef;
}

@end
