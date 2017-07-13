//
//  RouteManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "RouteManager.h"
#import "AddProjectViewController.h"
#import "ProjectDetailWindow.h"
#import "ProjectModel.h"
@interface RouteManager()

@property(nonatomic,strong)AddProjectViewController * addProjectViewControllerRef;
@property(nonatomic,strong)NSMutableDictionary<NSString*,ProjectDetailWindow*> *detailWindows;


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

#pragma mark -- centeral route

-(void)presentAddProjectViewControllerWithVC:(NSViewController *)controller{
    [self.addProjectViewControllerRef clearUI];
    if (controller) {
        [controller presentViewControllerAsModalWindow:self.addProjectViewControllerRef];
    }else{
        [[NSApplication sharedApplication].keyWindow.contentViewController presentViewControllerAsModalWindow:self.addProjectViewControllerRef];
    }
}

-(void)showProjectDetailsWindow:(ProjectModel *)projectModel{
    for (NSString * proPath in self.detailWindows.allKeys) {
        if ([proPath isEqualToString:projectModel.projectPath]) {
            ProjectDetailWindow * window = self.detailWindows[proPath];
            [window updateViewWithModel:projectModel];
            [window showWindow:nil];
            return;
        }
    }
    ProjectDetailWindow * window = [[ProjectDetailWindow alloc]initWithWindowNibName:@"ProjectDetailWindow"];
    [window updateViewWithModel:projectModel];
    [window showWindow:nil];
    [self.detailWindows setObject:window forKey:projectModel.projectPath];
}


#pragma mark -- setter and getter

-(AddProjectViewController *)addProjectViewControllerRef{
    if (!_addProjectViewControllerRef) {
        _addProjectViewControllerRef = [[AddProjectViewController alloc]init];
    }
    return _addProjectViewControllerRef;
}

-(NSMutableDictionary<NSString *,ProjectDetailWindow *> *)detailWindows{
    if (!_detailWindows) {
        _detailWindows = [NSMutableDictionary new];
    }
    return _detailWindows;
}

@end
