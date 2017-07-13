//
//  AddProjectViewModel.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "AddProjectViewModel.h"

@implementation AddProjectViewModel



-(void)clearModel{
    self.projectRealName = @"";
    self.projectPath = @"";
    self.projectName = @"";
}

#pragma mark -- setter and getter

-(NSString *)projectName{
    if (!_projectName) {
        _projectName=@"";
    }
    return _projectName;
}

-(NSString *)projectPath{
    if (!_projectPath) {
        _projectPath=@"";
    }
    return _projectPath;
}

-(NSString *)projectRealName{
    if (!_projectRealName) {
        _projectRealName=@"";
    }
    return _projectRealName;
}

@end
