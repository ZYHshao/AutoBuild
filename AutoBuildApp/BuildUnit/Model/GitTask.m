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
#define SCRIPT_FORMAT_STRING_GIT_CHECK_OUT @"do shell script \"GIT_DIR=%@ git checkout %@\""
#define SCRIPT_FORMAT_STRING_GIT_PULL @"do shell script \"GIT_DIR=%@ git pull\""

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
        self.mode = BaseTaskModeShell;
        [self createFormatStringAndInfo];
    }
    return self;
}

-(void)createFormatStringAndInfo{
    if (self.type == GitTaskTypeGetBranchList) {
        self.scriptFormat = [NSString stringWithFormat:SCRIPT_FORMAT_STRING_GIT_BRANCH,self.gitDicFullPath];
        self.taskInfo = @"请求Git分支信息";
    }else if(self.type == GitTaskTypeCheckOut){
        self.scriptFormat= [NSString stringWithFormat:SCRIPT_FORMAT_STRING_GIT_CHECK_OUT,self.gitDicFullPath,self.project.selectGitBranch];
        self.taskInfo = [NSString stringWithFormat:@"检查%@分支",self.project.selectGitBranch];
    }else if(self.type==GitTaskTypePull){
        self.scriptFormat = [NSString stringWithFormat:SCRIPT_FORMAT_STRING_GIT_PULL,self.gitDicFullPath];
        self.taskInfo = @"拉取新代码";
    }
}

@end
