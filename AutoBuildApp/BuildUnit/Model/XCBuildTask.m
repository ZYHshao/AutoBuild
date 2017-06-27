//
//  XCBuildTask.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "XCBuildTask.h"
#import "ProjectModel.h"

#define SCRIPT_FORMAT_STRING_CLEAN @"do shell script \"xcodebuild clean -%@ %@ -scheme %@ CONFIGURATION=%@\""


@interface XCBuildTask()

@property(nonatomic,weak)ProjectModel * project;

@end


@implementation XCBuildTask

-(instancetype)initWithProject:(ProjectModel *)project taskType:(XCBuildTaskType)taskType{
    self = [super init];
    if (self) {
        self.project = project;
        [self createFormatString];
    }
    return self;
}

-(void)createFormatString{
    _scriptFormat = [NSString stringWithFormat:SCRIPT_FORMAT_STRING_CLEAN,self.project.projectType,self.project.projectPath,self.project.scheme,self.project.buildConfiguration];
}

@end
