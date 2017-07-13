//
//  XCBuildTask.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTask.h"



@class ProjectModel;

typedef NS_ENUM(NSUInteger, XCBuildTaskType) {
    XCBuildTaskTypeClean,
    XCBuildTaskTypeExportArchive,
    XCBuildTaskTypeExportIPA,
};

@interface XCBuildTask : BaseTask

-(instancetype)initWithProject:(ProjectModel *)project taskType:(XCBuildTaskType)taskType;



@end
