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

-(NSArray *)getAllProject;

-(NSString *)addProject:(ProjectModel *)project;

@end
