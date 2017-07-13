//
//  GreatUserInterfaceControl.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/25.
//  Copyright © 2017年 jaki. All rights reserved.
// 全局UI控制

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GUCViewID) {
    GUCMainView=0
};

@interface GreatUserInterfaceControl : NSObject

+(instancetype)defaultControl;

-(void)addObserver:(id)observer inViewID:(GUCViewID)viewID withAction:(SEL)sel;

-(void)removeObserver:(id)observer inViewID:(GUCViewID)viewID;

-(void)removeObserver:(id)observer;

-(void)refreshView:(GUCViewID)viewID;

@end
