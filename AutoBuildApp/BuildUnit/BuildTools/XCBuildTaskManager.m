//
//  XCBuildTaskManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "XCBuildTaskManager.h"
#import "ProjectTask.h"
#import "BaseTask.h"
@interface XCBuildTaskManager()

@property(nonatomic,strong)NSMutableDictionary<NSString*,NSOperationQueue*> * opreationQueueMap;

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

-(void)runTask:(ProjectTask *)task stepCallBack:(void (^)(int step,NSDictionary *,CGFloat progress,NSString * log,NSString * finishString))stepCallBack{
    for (NSString * key in self.opreationQueueMap.allKeys) {
        if ([key isEqualToString:task.projectPath]) {
            NSOperationQueue * queue = [self.opreationQueueMap valueForKey:key];
            [queue cancelAllOperations];
            NSArray<BaseTask*> * array = [task createTaskGroup];
            [self.allRuningProjectTask addObject:task];
            [self addOperation:queue taskArray:array callBack:stepCallBack task:task];
            return;
        }
    }
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1;
    [self.opreationQueueMap setObject:queue forKey:task.projectPath];
    [self.allRuningProjectTask addObject:task];
    NSArray<BaseTask*> * array = [task createTaskGroup];
    [self addOperation:queue taskArray:array callBack:stepCallBack task:task];

}

-(void)cancelTask:(ProjectTask *)task{
    [self.allRuningProjectTask removeObject:task];
    for (NSString * key in self.opreationQueueMap.allKeys) {
        if ([key isEqualToString:task.projectPath]) {
            NSOperationQueue * queue = [self.opreationQueueMap valueForKey:key];
            [queue cancelAllOperations];
            return;
        }
    }
}

-(void)removeTask:(ProjectTask *)task{
    [self cancelTask:task];
    [self.opreationQueueMap removeObjectForKey:task.projectPath];
}


#pragma mark -- inner
-(void)addOperation:(NSOperationQueue *)queue taskArray:(NSArray<BaseTask*> *)array callBack:(void (^)(int step,NSDictionary *,CGFloat progress,NSString * log,NSString * finishString))stepCallBack task:(ProjectTask*)task{
    __weak typeof(self) __self = self;
    [queue addOperationWithBlock:^{
        for (int i=0; i<array.count; i++) {
            NSDictionary * errorDic = nil;
            NSAppleScript * script = [[NSAppleScript alloc]initWithSource:array[i].scriptFormat];
            NSAppleEventDescriptor* descript = [script executeAndReturnError:&errorDic];
            task.progress = (i+1.0)/task.totalTask;
            dispatch_async(dispatch_get_main_queue(), ^{
                stepCallBack(i,errorDic,task.progress,descript.stringValue,array[i].taskInfo);
            });
            
            //如果有错误 取消掉后续任务
            if (errorDic) {
                [__self.allRuningProjectTask removeObject:task];
                return ;
            }
            if (i==array.count-1) {
                //完成的任务 取消掉
                [__self.allRuningProjectTask removeObject:task];
            }
        }
    }];
}

#pragma mark -- getter and setter
-(NSMutableDictionary *)opreationQueueMap{
    if (!_opreationQueueMap) {
        _opreationQueueMap = [NSMutableDictionary new];
    }
    return _opreationQueueMap;
}

-(NSMutableArray<ProjectTask *> *)allRuningProjectTask{
    if (!_allRuningProjectTask) {
        _allRuningProjectTask = [NSMutableArray new];
    }
    return _allRuningProjectTask;
}

@end
