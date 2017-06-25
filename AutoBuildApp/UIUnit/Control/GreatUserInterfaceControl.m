//
//  GreatUserInterfaceControl.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/25.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "GreatUserInterfaceControl.h"

#define MainViewShouldReloadData @"MainViewShouldReloadData"

@interface GreatUserInterfaceControl()

@property (nonatomic,strong)NSMutableArray * observerList;

@property (nonatomic,strong)NSArray * viewIDToNotification;

@end

@implementation GreatUserInterfaceControl

+(instancetype)defaultControl{
    static dispatch_once_t onceToken;
    static GreatUserInterfaceControl * control = nil;
    dispatch_once(&onceToken, ^{
        if (!control) {
            control = [[GreatUserInterfaceControl alloc]init];
        }
    });
    return control;
}

-(void)addObserver:(id)observer inViewID:(GUCViewID)viewID withAction:(SEL)sel{
    NSArray * array = self.observerList[viewID];
    BOOL has = NO;
    for (id obj in array) {
        if (obj == observer) {
            has = YES;
        }
    }
    if (!has) {
        NSArray * array = self.observerList[viewID];
        NSMutableArray * newArray = [[NSMutableArray alloc]initWithArray:array];
        [newArray addObject:observer];
        [self.observerList replaceObjectAtIndex:viewID withObject:newArray];
        [[NSNotificationCenter defaultCenter]addObserver:observer selector:sel name:self.viewIDToNotification[viewID] object:nil];
    }
}

-(void)removeObserver:(id)observer inViewID:(GUCViewID)viewID{
    NSArray * array = self.observerList[viewID];
    NSMutableArray * newArray = [[NSMutableArray alloc]initWithArray:array];
    BOOL has = NO;
    for (id obj in newArray) {
        if (obj == observer) {
            has = YES;
        }
    }
    if (has) {
        [[NSNotificationCenter defaultCenter]removeObserver:observer name:self.viewIDToNotification[viewID] object:nil];
        [newArray removeObject:observer];
        [self.observerList replaceObjectAtIndex:viewID withObject:newArray];
    }
   
}

-(void)removeObserver:(id)observer{
    for (int i=0; i<self.observerList.count; i++) {
        NSArray * array = self.observerList[i];
        NSMutableArray * newArray = [[NSMutableArray alloc]initWithArray:array];
        BOOL has = NO;
        for (id obj in newArray) {
            if (obj == observer) {
                has = YES;
            }
        }
        if (has) {
            [[NSNotificationCenter defaultCenter]removeObserver:observer name:self.viewIDToNotification[i] object:nil];
            [newArray removeObject:observer];
            [self.observerList replaceObjectAtIndex:i withObject:newArray];
        }
    }
}

-(void)refreshView:(GUCViewID)viewID{
    [[NSNotificationCenter defaultCenter]postNotificationName:self.viewIDToNotification[viewID] object:nil];
}

#pragma mark - setter and getter

-(NSMutableArray *)observerList{
    if (!_observerList) {
        _observerList = [NSMutableArray array];
        //根据枚举数 初始化数组元素
        [_observerList addObjectsFromArray:@[@[]]];
    }
    return _observerList;
}

-(NSArray *)viewIDToNotification{
    if (!_viewIDToNotification) {
        _viewIDToNotification = @[MainViewShouldReloadData];
    }
    return _viewIDToNotification;
}
@end
