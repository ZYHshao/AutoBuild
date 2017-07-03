//
//  GitTask.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/30.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "BaseTask.h"

@class ProjectModel;

typedef NS_ENUM(NSUInteger, GitTaskType) {
    GitTaskTypeGetBranchList
};

@interface GitTask : BaseTask
-(instancetype)initWithProject:(ProjectModel *)project taskType:(GitTaskType)taskType;

@end
