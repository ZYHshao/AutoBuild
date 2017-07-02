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
        _ipaType = [coder decodeObjectForKey:@"ipaType"];
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
    [coder encodeObject:_ipaType forKey:@"ipaType"];
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

-(NSString *)ipaType{
    if (!_ipaType) {
        _ipaType = @"ad-hoc";
    }
    return _ipaType;
}

-(NSString *)gitFilePath{
    NSArray * strs = [self.projectPath componentsSeparatedByString:@"/"];
    NSMutableArray * newStrs = [NSMutableArray arrayWithArray:strs];
    [newStrs removeLastObject];
    NSString * string = [newStrs componentsJoinedByString:@"/"];
    return [NSString stringWithFormat:@"%@/.git",string];
}

#pragma mark -- mathod
-(BOOL)couldStartPeoject:(NSString *__autoreleasing *)error{
    switch (self.buildModel) {
        case ProjectUserOwnerModel:
        {
            if (self.scheme.length==0) {
                *error = @"必须填写项目的Scheme";
                return NO;
            }
            if (self.archivePath.length==0) {
                *error = @"必须设置Archive文件的输出目录";
                return NO;
            }
            if (self.ipaPath.length==0) {
                *error = @"必须设置IPA文件的输出目录";
                return NO;
            }
            return YES;
        }
            break;
        case ProjectSemiAuto:
        {
            
        }
            break;
        case ProjectAuto:
        {
            
        }
            break;
    }
    return NO;
}

@end
