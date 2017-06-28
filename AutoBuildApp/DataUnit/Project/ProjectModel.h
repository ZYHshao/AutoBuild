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

@interface ProjectModel : NSObject

@property(nonatomic,strong)NSString * projectPath;
@property(nonatomic,strong)NSString * projectName;

#pragma mark -- build Property
@property(nonatomic,strong)NSString * scheme; //default == projectRealName
@property(nonatomic,strong)NSString * archivePath;
@property(nonatomic,strong)NSString * buildConfiguration;//Debug or Release default debug
@property(nonatomic,strong)NSString * ipaPath;
@property(nonatomic,assign)ProjectBuildModel buildModel; //defaule == UserOwnerModel



#pragma mark -- mark noemal
@property(nonatomic,strong)NSString * log; //log message

#pragma mark -- inner property
@property(nonatomic,strong)NSString * projectRealName;
@property(nonatomic,strong)NSString * projectType; //project or workspace

@end
