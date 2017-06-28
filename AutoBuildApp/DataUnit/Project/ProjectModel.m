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
        _scheme = [coder decodeObjectForKey:@"scheme"];
        _archivePath = [coder decodeObjectForKey:@"archivePath"];
        _buildConfiguration = [coder decodeObjectForKey:@"buildConfiguration"];
        _ipaPath = [coder decodeObjectForKey:@"ipaPath"];
        _buildModel = [coder decodeIntegerForKey:@"buildModel"];
        _projectType = [coder decodeObjectForKey:@"projectType"];
        _log = [coder decodeObjectForKey:@"log"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_projectName forKey:@"projectName"];
    [coder encodeObject:_projectPath forKey:@"projectPath"];
    [coder encodeObject:_projectRealName forKey:@"projectRealName"];
    [coder encodeObject:_scheme forKey:@"scheme"];
    [coder encodeObject:_archivePath forKey:@"archivePath"];
    [coder encodeObject:_buildConfiguration forKey:@"buildConfiguration"];
    [coder encodeObject:_ipaPath forKey:@"ipaPath"];
    [coder encodeInteger:_buildModel forKey:@"buildModel"];
    [coder encodeObject:_projectType forKey:@"projectType"];
    [coder encodeObject:_log forKey:@"log"];
}


#pragma mark -- getter and setter

-(NSString *)scheme{
    if (!_scheme) {
        if (self.projectRealName) {
            _scheme = self.projectRealName;
        }else{
            _scheme=@"";
        }
    }
    return _scheme;
}

-(NSString *)archivePath{
    if (!_archivePath) {
        _archivePath = @"";
    }
    return _archivePath;
}

-(NSString *)buildConfiguration{
    if (!_buildConfiguration) {
        _buildConfiguration = @"Debug";
    }
    return _buildConfiguration;
}

-(NSString *)ipaPath{
    if (!_ipaPath) {
        _ipaPath=@"";
    }
    return _ipaPath;
}

-(ProjectBuildModel)buildModel{
    if (!_buildModel) {
        _buildModel = ProjectUserOwnerModel;
    }
    return _buildModel;
}

-(NSString *)projectType{
    if (!_projectType) {
        _projectType = @"";
    }
    return _projectType;
}

-(NSString *)log{
    if (!_log) {
        _log = @"开始构建你的自动化打包工程吧!Have fun! @^_^@";
    }
    return _log;
}

@end
