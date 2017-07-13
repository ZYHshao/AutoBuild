//
//  MainViewModel.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "MainViewTableCellModel.h"
#import "ProjectModel.h"

@interface MainViewModel : NSObject<NSTableViewDataSource,NSTableViewDelegate>

@property(nonatomic,strong)NSMutableArray<ProjectModel*> * projectArray;

@property (nonatomic,strong)NSMutableArray<MainViewTableCellModel *> * dataArray;

@property (nonatomic,weak)id owner;

-(void)registerTableView:(NSTableView *)tableView;
-(void)reloadData;

@end
