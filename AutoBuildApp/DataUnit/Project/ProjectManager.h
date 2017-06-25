//
//  ProjectManager.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectModel.h"

@interface ProjectManager : NSObject

+(instancetype)defaultManager;


/**
 获取所有项目

 @return 项目列表
 */
-(NSArray *)getAllProject;

/**
 添加一个项目

 @param project 项目对象
 @return 是否成功 返回字符串 success表示成功 否则为错误信息
 */
-(NSString *)addProject:(ProjectModel *)project;

/**
 删除一个项目

 @param project 项目对象
 */
-(void)deleteProject:(ProjectModel *)project;

@end
