//
//  ViewController.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "MainViewModel.h"
#import "MainViewTableCellModel.h"
#import "MainTopBar.h"

@interface ViewController()

@property (weak) IBOutlet MainTopBar *topBarView;
@property (nonatomic,strong)NSTableView * tableView;

@property (nonatomic,strong)MainViewModel * controlModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self installData];
    [self installView];
}

-(void)installData{
    /*test*/
    MainViewTableCellModel * testModel = [[MainViewTableCellModel alloc]init];
    testModel.title = @"唯享客";
    [self.controlModel.dataArray addObject:testModel];
    MainViewTableCellModel * testModel2 = [[MainViewTableCellModel alloc]init];
    testModel2.title = @"AutoBuild";
    [self.controlModel.dataArray addObject:testModel2];
    [self.controlModel reloadData];
    
    /*....*/
}

-(void)installView{    
    //tableView
    NSScrollView * scrollView = [[NSScrollView alloc]init];
    scrollView.hasVerticalScroller = YES;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.top.equalTo(self.topBarView.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    scrollView.contentView.documentView = self.tableView;
}

#pragma mark -- setter and getter


-(NSTableView *)tableView{
    if (!_tableView) {
        _tableView = [[NSTableView alloc]init];
        _tableView.dataSource = self.controlModel;
        _tableView.delegate = self.controlModel;
        _tableView.headerView = nil;
        NSTableColumn * column = [[NSTableColumn alloc]initWithIdentifier:@"TaskList"];
        [_tableView addTableColumn:column];
    }
    return _tableView;
}

-(MainViewModel *)controlModel{
    if (!_controlModel) {
        _controlModel = [[MainViewModel alloc]init];
        [_controlModel registerTableView:self.tableView];
        _controlModel.owner = self;
    }
    return _controlModel;
}

@end
