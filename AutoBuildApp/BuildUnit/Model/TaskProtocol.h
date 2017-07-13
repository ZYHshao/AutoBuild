//
//  TaskProtocol.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BaseTaskMode) {
    BaseTaskModeShell,
    BaseTaskiInnerTask,
};

@protocol TaskProtocol <NSObject>

@property (nonatomic,strong)NSString * scriptFormat;

@property (nonatomic,strong)NSString * taskInfo;

@property (nonatomic,assign)BaseTaskMode mode;

-(void)innerTask:(void(^)(id data,BOOL finish,CGFloat progress))taskInfoCallback;

@end
