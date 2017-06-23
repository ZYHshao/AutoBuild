//
//  ProjectManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ProjectManager.h"
#import "DBManager.h"

@interface ProjectManager()

@property(nonatomic,strong)NSMutableArray * projectArray;

@end

@implementation ProjectManager

+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static ProjectManager * manager = nil;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[ProjectManager alloc]init];
        }
    });
    return manager;
}

-(NSArray *)getAllProject{
    return [self.projectArray copy];
}

-(NSString*)addProject:(ProjectModel *)project{
    for (ProjectModel* obj in self.projectArray) {
        if ([obj.projectPath isEqualToString:project.projectPath]) {
            return @"已存在项目";
        }
    }
    [self.projectArray addObject:project];
    [[DBManager defaultManager] addProject:project];
    return @"success";
}

#pragma mark -- setter and getter
-(NSMutableArray *)projectArray{
    if (!_projectArray) {
        _projectArray = [[NSMutableArray alloc]init];
        [_projectArray addObjectsFromArray:[[DBManager defaultManager] getAllProjects]];
    }
    return _projectArray;
}

@end
