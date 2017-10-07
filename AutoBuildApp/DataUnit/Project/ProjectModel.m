//
//  ProjectModel.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ProjectModel.h"

#define GIT_BRANCH_NULL_TIP @"请重新刷新分支列表"

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
        _gitBranchList = [coder decodeObjectForKey:@"gitBranchList"];
        _selectGitBranch = [coder decodeObjectForKey:@"selectGitBranch"];
        _uKey = [coder decodeObjectForKey:@"uKey"];
        _api_key = [coder decodeObjectForKey:@"api_key"];
        _authority = [coder decodeIntegerForKey:@"authority"];
        _password = [coder decodeObjectForKey:@"password"];
        _updataMessage = [coder decodeObjectForKey:@"updataMessage"];
        _provisioningId = [coder decodeObjectForKey:@"provisioningId"];
        _provisioningName = [coder decodeObjectForKey:@"provisioningName"];
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
    [coder encodeObject:_gitBranchList forKey:@"gitBranchList"];
    [coder encodeObject:_selectGitBranch forKey:@"selectGitBranch"];
    [coder encodeObject:_uKey forKey:@"uKey"];
    [coder encodeObject:_api_key forKey:@"api_key"];
    [coder encodeInteger:_authority forKey:@"authority"];
    [coder encodeObject:_password forKey:@"password"];
    [coder encodeObject:_updataMessage forKey:@"updataMessage"];
    [coder encodeObject:_provisioningId forKey:@"provisioningId"];
    [coder encodeObject:_provisioningName forKey:@"provisioningName"];
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

-(NSArray *)gitBranchList{
    if (!_gitBranchList) {
        _gitBranchList = @[GIT_BRANCH_NULL_TIP];
    }
    return _gitBranchList;
}

-(NSString *)selectGitBranch{
    if (!_selectGitBranch) {
        _selectGitBranch = self.gitBranchList.firstObject;
    }
    return _selectGitBranch;
}

-(NSString *)uKey{
    if (!_uKey) {
        _uKey = @"";
    }
    return _uKey;
}

-(NSString *)api_key{
    if (!_api_key) {
        _api_key = @"";
    }
    return _api_key;
}

-(DownLoadAuthority)authority{
    if (_authority==0) {
        _authority = DownLoadAuthorityPublic;
    }
    return _authority;
}

-(NSString *)password{
    if (!_password) {
        _password = @"";
    }
    return _password;
}

-(NSString *)updataMessage{
    if (!_updataMessage) {
        _updataMessage = @"";
    }
    return _updataMessage;
}

-(NSString *)provisioningId{
    if (!_provisioningId) {
        _provisioningId = @"";
    }
    return _provisioningId;
}

-(NSString *)provisioningName{
    if (!_provisioningName) {
        _provisioningName = @"";
    }
    return _provisioningName;
}

#pragma mark -- mathod
-(BOOL)couldStartPeoject:(NSString *__autoreleasing *)error{
    switch (self.buildModel) {
        case ProjectAuto:
        {
            if ([self.selectGitBranch isEqualToString:GIT_BRANCH_NULL_TIP]) {
                *error = @"您必须配置一个自动化构建的Git分支";
                return NO;
            }
        }
        case ProjectSemiAuto:
        {
            if (self.uKey.length==0) {
                *error = @"您必须配置蒲公英平台的uKey凭证";
                return NO;
            }
            if (self.api_key.length==0) {
                *error = @"您必须配置蒲公英平台的api_key凭证";
                return NO;
            }
            if (self.authority==DownLoadAuthorityprivate && self.password.length==0) {
                *error = @"您必须设置下载密码";
                return NO;
            }
        }
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
            if (self.provisioningId.length==0||self.provisioningName.length==0) {
                *error = @"请填写正确的Provisioning Profile文件信息";
                return NO;
            }
            return YES;
        }

    }
    return NO;
}

@end
