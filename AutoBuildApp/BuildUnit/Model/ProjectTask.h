//
//  ProjectTask.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//


#import <Foundation/Foundation.h>

@class ProjectModel;
@class BaseTask;

@interface ProjectTask :NSObject

-(instancetype)initWithProject:(ProjectModel *)project;

-(NSArray<BaseTask *> *)createTaskGroup;


@property (nonatomic,strong,readonly)NSString* projectPath;

@property (nonatomic,assign)CGFloat progress;//0-1

@property (nonatomic,assign)int totalTask;

@property (nonatomic,assign)BOOL isCancel;

@end
