//
//  MainViewModel.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "MainViewModel.h"
#import "MainViewTableCellView.h"
#import "RouteManager.h"
#import "ProjectManager.h"
#import "GUC.h"

#define MAIN_TABLE_CELL_ID @"MainViewTableCellViewId"


@interface MainViewModel()
@property (nonatomic,weak)NSTableView * tableView;
@end

@implementation MainViewModel


-(void)registerTableView:(NSTableView *)tableView{
    self.tableView = tableView;
    [self.tableView setTarget:self];
    [self.tableView setDoubleAction:@selector(clickCell:)];
    [tableView registerNib:[[NSNib alloc] initWithNibNamed:@"MainViewTableCellView" bundle:[NSBundle mainBundle]] forIdentifier:MAIN_TABLE_CELL_ID];
}

-(void)reloadData{
    [self.tableView reloadData];
}

-(void)clickCell:(id)sender{
    ProjectModel * model =self.projectArray[[self.tableView clickedRow]];
    [[RouteManager defaultManager] showProjectDetailsWindow:model];
}

-(void)deleteProject{
    ProjectModel * model =self.projectArray[[self.tableView clickedRow]];
    [[ProjectManager defaultManager]deleteProject:model];
    //需要刷新界面
    GUC_REFRESH(GUCMainView);
}

#pragma mark -- tableView DataSource

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.dataArray.count;
}

#pragma mark -- tableView Delegate

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    MainViewTableCellView * rowView = [tableView makeViewWithIdentifier:MAIN_TABLE_CELL_ID owner:self];
    [rowView updateViewWithModel:self.dataArray[row]];
    return rowView;
}
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 60.0;
}

#pragma mark -- release

-(void)dealloc{
    self.tableView.delegate = nil;
    self.tableView.dataSource =nil;
    self.owner = nil;
}

#pragma mark -- setter and getter

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

-(NSMutableArray<ProjectModel *> *)projectArray{
    if (!_projectArray) {
        _projectArray = [NSMutableArray array];
    }
    return _projectArray;
}

@end
