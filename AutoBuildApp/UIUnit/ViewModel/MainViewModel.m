//
//  MainViewModel.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "MainViewModel.h"
#import "MainViewTableCellView.h"

#define MAIN_TABLE_CELL_ID @"MainViewTableCellViewId"


@interface MainViewModel()
@property (nonatomic,weak)NSTableView * tableView;
@end

@implementation MainViewModel


-(void)registerTableView:(NSTableView *)tableView{
    self.tableView = tableView;
    [tableView registerNib:[[NSNib alloc] initWithNibNamed:@"MainViewTableCellView" bundle:[NSBundle mainBundle]] forIdentifier:MAIN_TABLE_CELL_ID];
}

-(void)reloadData{
    [self.tableView reloadData];
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
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
