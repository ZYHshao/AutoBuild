//
//  RouteManager.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@class ProjectModel;

@interface RouteManager : NSObject


+(instancetype)defaultManager;

-(void)presentAddProjectViewControllerWithVC:(NSViewController *)controller;

-(void)showProjectDetailsWindow:(ProjectModel *)projectModel;

@end
