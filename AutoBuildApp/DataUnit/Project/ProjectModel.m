//
//  ProjectModel.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ProjectModel.h"

@implementation ProjectModel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _projectName = [coder decodeObjectForKey:@"projectName"];
        _projectPath = [coder decodeObjectForKey:@"projectPath"];
        _projectRealName = [coder decodeObjectForKey:@"projectRealName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_projectName forKey:@"projectName"];
    [coder encodeObject:_projectPath forKey:@"projectPath"];
    [coder encodeObject:_projectRealName forKey:@"projectRealName"];
    
}

@end
