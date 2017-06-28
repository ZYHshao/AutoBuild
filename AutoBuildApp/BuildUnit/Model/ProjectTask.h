//
//  ProjectTask.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//


#import "BaseTask.h"

@class ProjectModel;

@interface ProjectTask :BaseTask

-(instancetype)initWithProject:(ProjectModel *)project;

-(NSArray<BaseTask *> *)createTaskGroup;


@property(nonatomic,strong,readonly)NSString* projectPath;

@end
