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

@property(nonatomic,strong)NSString * projectRealName;
@end