//
//  ProjectTask.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ProjectTask.h"
#import "ProjectModel.h"
#import "XCBuildTask.h"

@interface ProjectTask()

@property (nonatomic,weak)ProjectModel * project;

@end

@implementation ProjectTask

-(instancetype)initWithProject:(ProjectModel *)project{
    self = [super init];
    if (self) {
        self.project = project;
        _projectPath = project.projectPath;
    }
    return self;
}

-(NSArray *)createTaskGroup{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    XCBuildTask * taskBuild = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeClean];
    [array addObject:taskBuild];
    return array;
}

@end
