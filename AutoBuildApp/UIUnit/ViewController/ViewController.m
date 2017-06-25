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
#import "ProjectManager.h"
#import "GUC.h"

@interface ViewController()

@property (weak) IBOutlet MainTopBar *topBarView;
@property (nonatomic,strong)NSTableView * tableView;
@property (nonatomic,strong)NSMenu * itemMenu;

@property (nonatomic,strong)MainViewModel * controlModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    [self installData];
    [self installView];
}

-(void)dealloc{
    GUC_REMOVE_OBSERVER(self);
}

-(void)addNotification{
    GUC_ADD_OBSERVER(self, GUCMainView, NSSelectorFromString(@"reloadData"));
}

-(void)installData{
    [self.controlModel.projectArray addObjectsFromArray:[[ProjectManager defaultManager] getAllProject]];
    [self.controlModel.dataArray addObjectsFromArray:[self createCellModelWithProject:[[ProjectManager defaultManager] getAllProject]]];
    [self.controlModel reloadData];
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


-(NSArray<MainViewTableCellModel*>*)createCellModelWithProject:(NSArray<ProjectModel*> *)projects{
    NSMutableArray * res = [NSMutableArray new];
    for (int i=0; i<projects.count; i++) {
        MainViewTableCellModel * model = [MainViewTableCellModel new];
        model.projModel = projects[i];
        model.title = projects[i].projectName;
        [res addObject:model];
    }
    return [res copy];
}

-(void)reloadData{
    [self.controlModel.projectArray removeAllObjects];
    [self.controlModel.projectArray addObjectsFromArray:[[ProjectManager defaultManager] getAllProject]];
    [self.controlModel.dataArray removeAllObjects];
    [self.controlModel.dataArray addObjectsFromArray:[self createCellModelWithProject:[[ProjectManager defaultManager] getAllProject]]];
    [self.controlModel reloadData];
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
        _tableView.menu = self.itemMenu;
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

-(NSMenu *)itemMenu{
    if (!_itemMenu) {
        _itemMenu = [[NSMenu alloc]init];
        NSMenuItem * item = [[NSMenuItem alloc]init];
        item.title = @"删除项目";
        item.target = self.controlModel;
        item.action = NSSelectorFromString(@"deleteProject");
        [_itemMenu addItem:item];
    }
    return _itemMenu;
}

@end
