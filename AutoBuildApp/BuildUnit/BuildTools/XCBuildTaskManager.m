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

-(void)runTask:(ProjectTask *)task stepCallBack:(void (^)(int step,NSDictionary *,CGFloat progress,NSString * log,NSString * finishString,BOOL isFinish))stepCallBack{
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

-(void)getGitBranch:(ProjectModel *)project stepCallBack:(void (^)(NSDictionary *, NSString *, BOOL))stepCallBack{
    BaseTask * task = [[[ProjectTask alloc]initWithProject:project] createTaskGetGitBranch];
    NSAppleScript * script = [[NSAppleScript alloc]initWithSource:task.scriptFormat];
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{
        NSDictionary * errorDic = nil;
        NSAppleEventDescriptor* descript = [script executeAndReturnError:&errorDic];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (stepCallBack) {
                stepCallBack(errorDic,descript.stringValue,YES);
            }
        });
    }];
    [queue addOperation:op];
}

-(void)cancelTask:(ProjectTask *)task{
    for (ProjectTask * ta in self.allRuningProjectTask) {
        if ([ta.projectPath isEqualToString:task.projectPath]) {
            //已经执行operation任务无法终止 用标记来提前中断
            ta.isCancel = YES;
        }
    }
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


-(void)getGitBranch:(ProjectModel *)project{
    
}

#pragma mark -- inner
-(void)addOperation:(NSOperationQueue *)queue taskArray:(NSArray<BaseTask*> *)array callBack:(void (^)(int step,NSDictionary *,CGFloat progress,NSString * log,NSString * finishString,BOOL isFinish))stepCallBack task:(ProjectTask*)task{
    __weak typeof(self) __self = self;
    [queue addOperationWithBlock:^{
        for (int i=0; i<array.count; i++) {
            NSDictionary * errorDic = nil;
            if (array[i].mode == BaseTaskModeShell) {
                NSAppleScript * script = [[NSAppleScript alloc]initWithSource:array[i].scriptFormat];
                NSAppleEventDescriptor* descript = [script executeAndReturnError:&errorDic];
                task.progress = (i+1.0)/task.totalTask;
                BOOL finish = NO;
                //如果有错误 取消掉后续任务
                if (errorDic) {
                    [__self.allRuningProjectTask removeObject:task];
                    finish = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        stepCallBack(i,errorDic,task.progress,descript.stringValue,array[i].taskInfo,finish);
                    });
                    return ;
                }
                if (i==array.count-1||task.isCancel) {
                    //完成的任务 取消掉
                    [__self.allRuningProjectTask removeObject:task];
                    finish = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        stepCallBack(i,errorDic,task.isCancel?0:task.progress,descript.stringValue,array[i].taskInfo,finish);
                    });
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    stepCallBack(i,errorDic,task.progress,descript.stringValue,array[i].taskInfo,finish);
                });
            }else if(array[i].mode == BaseTaskiInnerTask){
                [array[i] innerTask:^(id data, BOOL finish, CGFloat progress) {
                    if ((i==array.count-1&&finish)||task.isCancel) {
                        //完成的任务 取消掉
                        task.progress = (i+1.0)/task.totalTask;
                        [__self.allRuningProjectTask removeObject:task];
                        finish = YES;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            stepCallBack(i,nil,task.isCancel?0:task.progress,[NSString stringWithFormat:@"上传进度%f%%",progress*100],array[i].taskInfo,finish);
                        });
                        return;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        stepCallBack(i,nil,task.isCancel?0:task.progress,[NSString stringWithFormat:@"上传进度%f%%",progress*100],array[i].taskInfo,finish);
                    });
                }];
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
