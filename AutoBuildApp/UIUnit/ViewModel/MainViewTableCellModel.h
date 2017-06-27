//
//  MainViewTableCellModel.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectModel.h"

@interface MainViewTableCellModel : NSObject

@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)ProjectModel * projModel;
@property (nonatomic,strong)NSString * modelType;
/*...other...*/

@end
