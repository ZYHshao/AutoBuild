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
@property(nonatomic,assign)XCBuildTaskType type;

@end


@implementation XCBuildTask

-(instancetype)initWithProject:(ProjectModel *)project taskType:(XCBuildTaskType)taskType{
    self = [super init];
    if (self) {
        self.type = taskType;
        self.project = project;
        [self createFormatString];
    }
    return self;
}

-(void)createFormatString{
    if (self.type == XCBuildTaskTypeClean) {
        _scriptFormat = [NSString stringWithFormat:SCRIPT_FORMAT_STRING_CLEAN,self.project.projectType,self.project.projectPath,self.project.scheme,self.project.buildConfiguration];
    }else if (self.type == XCBuildTaskTypeExportArchive){
    
    }else if (self.type == XCBuildTaskTypeExportIPA){
        
    }else{
        _scriptFormat = @"";
    }
    
}

@end
