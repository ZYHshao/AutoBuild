//
//  ProjectTask.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskProtocol.h"

@class ProjectModel;

@interface ProjectTask : NSObject

-(instancetype)initWithProject:(ProjectModel *)project;

-(NSArray<TaskProtocol> *)createTaskGroup;


@property(nonatomic,strong,readonly)NSString* projectPath;

@end
