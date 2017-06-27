//
//  XCBuildTaskManager.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProjectTask;
@class ProjectModel;

@interface XCBuildTaskManager : NSObject

+(instancetype)defaultManager;


/**
 创建一个工程自动化任务

 @param project 项目对象
 @return 自动化任务对象
 */
-(ProjectTask*)createProjectTask:(ProjectModel *)project;


/**
 执行一个自动化任务

 @param task 任务对象
 @param stepCallBack 进度回调
 */
-(void)runTask:(ProjectTask *)task stepCallBack:(void(^)())stepCallBack;


/**
 取消一个自动化任务 并不会移除 只是停止执行

 @param task 任务对象
 */
-(void)cancelTask:(ProjectTask *)task;


/**
 移除一个自动化任务

 @param task 任务对象
 */
-(void)removeTask:(ProjectTask *)task;

@end
