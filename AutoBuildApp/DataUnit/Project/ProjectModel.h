//
//  ProjectModel.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ProjectBuildModel) {
    ProjectUserOwnerModel = 1, //自助模式
    ProjectSemiAuto,       //半自动
    ProjectAuto,           //全自动
};

typedef NS_ENUM(NSUInteger, DownLoadAuthority) {
    DownLoadAuthorityPublic =1,
    DownLoadAuthorityprivate, //need password
};

@interface ProjectModel : NSObject

@property(nonatomic,strong)NSString * projectPath;
@property(nonatomic,strong)NSString * projectName;

#pragma mark -- build Property
@property(nonatomic,strong)NSString * scheme; //default == projectRealName
@property(nonatomic,strong)NSString * archivePath;
@property(nonatomic,strong)NSString * buildConfiguration;//Debug or Release default debug
@property(nonatomic,strong)NSString * ipaPath;
@property(nonatomic,assign)ProjectBuildModel buildModel; //defaule == UserOwnerModel
@property(nonatomic,strong)NSString * ipaType;// ad-hoc app-store development enterprise
@property(nonatomic,strong)NSString * provisioningId;//PP flie id
@property(nonatomic,strong)NSString * provisioningName;//PP name

#pragma mark -- git Progerty
@property(nonatomic,strong)NSArray * gitBranchList;

#pragma mark -- upload file
@property(nonatomic,strong)NSString * uKey;
@property(nonatomic,strong)NSString * api_key;
@property(nonatomic,assign)DownLoadAuthority authority; //default public
@property(nonatomic,strong)NSString * password;
@property(nonatomic,strong)NSString * updataMessage;


#pragma mark -- mark noemal
@property(nonatomic,strong)NSString * log; //log message

#pragma mark -- inner property
@property(nonatomic,strong)NSString * projectRealName;
@property(nonatomic,strong)NSString * projectType; //project or workspace
@property(nonatomic,strong,readonly)NSString * gitFilePath;
@property(nonatomic,strong)NSString * selectGitBranch; //default this first of branch list

#pragma mark -- moment property
//下面这些属性不进行持久化 只进行临时存储


-(BOOL)couldStartPeoject:(NSString **)error;

@end
