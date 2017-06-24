//
//  ProjectDetailWindow.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/24.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ProjectModel;

@interface ProjectDetailWindow : NSWindowController

-(void)updateViewWithModel:(ProjectModel*)model;

@end
