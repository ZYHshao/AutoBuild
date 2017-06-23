//
//  DBManager.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/23.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProjectModel;

@interface DBManager : NSObject

+(instancetype)defaultManager;

-(NSArray<ProjectModel *>*)getAllProjects;

-(BOOL)addProject:(ProjectModel*)project;

@end
