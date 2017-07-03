//
//  GitTask.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/30.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "GitTask.h"
#import "ProjectModel.h"

#define SCRIPT_FORMAT_STRING_GIT_BRANCH @"do shell script \"GIT_DIR=%@ git branch\""

@interface GitTask()

@property(nonatomic,weak)ProjectModel * project;
@property(nonatomic,assign)GitTaskType type;
@property(nonatomic,copy)NSString * gitDicFullPath;

@end

@implementation GitTask

-(instancetype)initWithProject:(ProjectModel *)project taskType:(GitTaskType)taskType{
    self = [super init];
    if (self) {
        self.type = taskType;
        self.project = project;
        self.gitDicFullPath = project.gitFilePath;
        [self createFormatStringAndInfo];
    }
    return self;
}

-(void)createFormatStringAndInfo{
    if (self.type == GitTaskTypeGetBranchList) {
        self.scriptFormat = [NSString stringWithFormat:SCRIPT_FORMAT_STRING_GIT_BRANCH,self.gitDicFullPath];
        self.taskInfo = @"正在请求Git分支信息.......";
    }else{
        self.scriptFormat= @"";
    }
}

@end
