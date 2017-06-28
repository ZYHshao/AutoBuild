//
//  XCBuildTaskManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "XCBuildTaskManager.h"
#import "ProjectTask.h"
#import "TaskProtocol.h"
#import "XCBuildTask.h"
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

-(void)runTask:(ProjectTask *)task stepCallBack:(void (^)(int step,NSDictionary *))stepCallBack{
    __weak typeof(self) __self = self;
    for (NSString * key in self.opreationQueueMap.allKeys) {
        if ([key isEqualToString:task.projectPath]) {
            NSOperationQueue * queue = [self.opreationQueueMap valueForKey:key];
            [queue cancelAllOperations];
            NSArray * array = [task createTaskGroup];
            [self.allRuningProjectTask addObject:task];
            [queue addOperationWithBlock:^{
                for (int i=0; i<array.count-1; i++) {
                    NSDictionary * errorDic = nil;
                    NSAppleScript * script = [[NSAppleScript alloc]initWithSource:array[i]];
                    [script executeAndReturnError:&errorDic];
                    stepCallBack(i,errorDic);
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
            return;
        }
    }
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1;
    [self.opreationQueueMap setObject:queue forKey:task.projectPath];
    [self.allRuningProjectTask addObject:task];
    NSArray<TaskProtocol> * array = [task createTaskGroup];
    [queue addOperationWithBlock:^{
        for (int i=0; i<array.count; i++) {
            NSDictionary * errorDic = nil;
            NSAppleScript * script = [[NSAppleScript alloc]initWithSource:((XCBuildTask*)array[i]).scriptFormat];
            [script executeAndReturnError:&errorDic];
            stepCallBack(i,errorDic);
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
