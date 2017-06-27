//
//  XCBuildTaskManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "XCBuildTaskManager.h"
#import "ProjectTask.h"

@interface XCBuildTaskManager()

@property(nonatomic,strong)NSDictionary<NSString*,NSOperationQueue*> * opreationQueueMap;

@end


@implementation XCBuildTaskManager

+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static XCBuildTaskManager * manager = nil;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[XCBuildTaskManager alloc]init];
        }
    });
    return manager;
}

-(ProjectTask *)createProjectTask:(ProjectModel *)project{
    ProjectTask * pTask = [[ProjectTask alloc]initWithProject:project];
    return pTask;
}

-(void)runTask:(ProjectTask *)task stepCallBack:(void (^)())stepCallBack{
    for (NSString * key in self.opreationQueueMap.allKeys) {
        if ([key isEqualToString:task.projectPath]) {
            return;
        }
    }
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    [self.opreationQueueMap setValue:queue forKey:task.projectPath];
}

#pragma mark -- getter and setter
-(NSDictionary *)opreationQueueMap{
    if (!_opreationQueueMap) {
        _opreationQueueMap = [NSMutableDictionary new];
    }
    return _opreationQueueMap;
}

@end
