//
//  DBManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/23.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "DBManager.h"
#import "ProjectModel.h"

#define DBMANAGER_VERSION @"1.0"

@interface DBManager()

@property(nonatomic,strong)NSMutableArray<ProjectModel *> * projectArray;

@end

@implementation DBManager


+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static DBManager * manager = nil;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[DBManager alloc]init];
        }
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self installDB];
    }
    return self;
}

-(void)installDB{
    NSData * data = [NSData dataWithContentsOfFile:[self dataBasePath]];
    if (data) {
        NSArray<ProjectModel *>* array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.projectArray removeAllObjects];
        [self.projectArray addObjectsFromArray:array];
    }
}

-(NSString *)dataBasePath{
    NSString * homeDic = NSHomeDirectory();
    NSString * homePath = [homeDic stringByAppendingPathComponent:[NSString stringWithFormat:@"AutoB-dataBase_%@.db",DBMANAGER_VERSION]];
    return homePath;
}

-(NSArray<ProjectModel *> *)getAllProjects{
    return [self.projectArray copy];
}

-(BOOL)addProject:(ProjectModel *)project{
    __block BOOL error=NO;
    [self.projectArray enumerateObjectsUsingBlock:^(ProjectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.projectPath isEqualToString:project.projectPath]) {
            error = YES;
            *stop=YES;
        }
    }];
    if (error) {
        return NO;
    }
    [_projectArray addObject:project];
    [self syncDB];
    return YES;
}

-(void)syncDB{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.projectArray];
    [data writeToFile:[self dataBasePath] atomically:NO];
}

#pragma mark -- setter and getter
-(NSMutableArray<ProjectModel *> *)projectArray{
    if (!_projectArray) {
        _projectArray = [NSMutableArray new];
    }
    return _projectArray;
}


@end
