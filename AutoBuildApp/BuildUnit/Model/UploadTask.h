//
//  UploadTask.h
//  AutoBuildApp
//
//  Created by jaki on 2017/7/10.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "BaseTask.h"

@class ProjectModel;
@interface UploadTask : BaseTask
-(instancetype)initWithProject:(ProjectModel *)project;
@end
