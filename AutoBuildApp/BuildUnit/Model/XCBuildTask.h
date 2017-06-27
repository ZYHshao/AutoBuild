//
//  XCBuildTask.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskProtocol.h"



@class ProjectModel;

typedef NS_ENUM(NSUInteger, XCBuildTaskType) {
    XCBuildTaskTypeClean,
    XCBuildTaskTypeExportArchive,
    XCBuildTaskTypeExportIPA,
};

@interface XCBuildTask : NSObject<TaskProtocol>

-(instancetype)initWithProject:(ProjectModel *)project taskType:(XCBuildTaskType)taskType;


/**
 格式化的任务脚本
 */
@property (nonatomic,strong,readonly)NSString * scriptFormat;

@end
