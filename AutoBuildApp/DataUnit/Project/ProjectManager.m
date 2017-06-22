//
//  ProjectManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ProjectManager.h"

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

-(void)addProject:(ProjectModel *)project{
    [self.projectArray addObject:project];
}

#pragma mark -- setter and getter
-(NSMutableArray *)projectArray{
    if (!_projectArray) {
        _projectArray = [[NSMutableArray alloc]init];
    }
    return _projectArray;
}

@end
