//
//  AddProjectViewModel.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddProjectViewModel : NSObject

@property(nonatomic,strong)NSString * projectPath;
@property(nonatomic,strong)NSString * projectName;

/*in line */
@property(nonatomic,strong)NSString * projectRealName;
-(void)clearModel;

@end
