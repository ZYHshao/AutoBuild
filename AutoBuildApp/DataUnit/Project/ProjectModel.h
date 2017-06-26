//
//  ProjectModel.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject

@property(nonatomic,strong)NSString * projectPath;
@property(nonatomic,strong)NSString * projectName;

#pragma mark -- build Property
@property(nonatomic,strong)NSString * scheme; //default == projectRealName
@property(nonatomic,strong)NSString * archivePath;
@property(nonatomic,strong)NSString * buildConfiguration;//Debug or Release default debug
@property(nonatomic,strong)NSString * ipaPath;

#pragma mark -- inner property
@property(nonatomic,strong)NSString * projectRealName;

@end
