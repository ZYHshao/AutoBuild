//
//  ProjectDetailWindow.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/24.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ProjectDetailWindow.h"
#import <Masonry/Masonry.h>
#import "ProjectModel.h"
#import "ProjectManager.h"
#import "GUC.h"
#import "XCBuildTaskManager.h"
#import "ProjectTask.h"


#define MODEL_USER_WONER_TIP @"自助模式下将只进行工程的自动化打包，必须配置编译模块。"
#define MODEL_SEMI_AUTO_TIP @"半自动模式下将进行工程的打包与发布，必须配置编译模块与发布模块。"
#define MODEL_AOTU_TIP @"全自动模式将帮您进行工程的代码更新，打包，发布等一系列操作，必须配置编译、GIT与发布模块。"


@interface ProjectDetailWindow ()

@property (nonatomic,strong)ProjectModel * project;

@property (weak) IBOutlet NSTextField *titleLabel;

@property (nonatomic,strong)NSArray * modelTipMessageArray;

@property (nonatomic,weak)ProjectTask * currentProjectTask;

@property (nonatomic,assign)BOOL isRefreshingGitBranch;

//MARK: build
@property (weak) IBOutlet NSTextField *schemeTextField;
@property (weak) IBOutlet NSTextField *archiveTextField;
@property (weak) IBOutlet NSPopUpButton *buildConfiguration;
@property (weak) IBOutlet NSTextField *ipaTextField;
@property (weak) IBOutlet NSButton *selectArchivePath;
@property (weak) IBOutlet NSButton *selectIpaPath;
@property (weak) IBOutlet NSButton *saveBuild;
@property (weak) IBOutlet NSPopUpButton *ipaTypeButton;

//MARK: GIT
@property (weak) IBOutlet NSTextField *gitUnableTipOne;
@property (weak) IBOutlet NSTextField *gitUnableTipTwo;
@property (weak) IBOutlet NSView *gitContentView;
@property (weak) IBOutlet NSPopUpButton *branchListButton;
@property (weak) IBOutlet NSProgressIndicator *refreshBranchTip;
@property (weak) IBOutlet NSButton *refreshBranchButton;

//MARK: upload
@property (weak) IBOutlet NSTextField *uKeyField;
@property (weak) IBOutlet NSTextField *apiKeyField;
@property (weak) IBOutlet NSPopUpButton *aothorityButton;
@property (weak) IBOutlet NSSecureTextField *passwordField;
@property (weak) IBOutlet NSTextField *uploadMessageLabel;
@property (weak) IBOutlet NSButton *savaUploadInfoButton;


//MARK: Normal
@property (weak) IBOutlet NSPopUpButton *buildModelSelectButton;
@property (unsafe_unretained) IBOutlet NSTextView *logWindow;

@property (weak) IBOutlet NSButton *startButton;
@property (weak) IBOutlet NSButton *stopButton;

@property (weak) IBOutlet NSTextField *modelTipLabel;
@property (weak) IBOutlet NSProgressIndicator *progressBar;

@end

@implementation ProjectDetailWindow

- (void)windowDidLoad {
    [super windowDidLoad];
    [self remakeTitleBar];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}



-(void)remakeTitleBar{
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    [self.window setMovableByWindowBackground:YES];
    [self.window setStyleMask:[self.window styleMask] | NSWindowStyleMaskFullSizeContentView];
    NSView * themeView = self.window.contentView.superview;
    NSView * titleView = themeView.subviews[1];
    titleView.autoresizesSubviews = YES;
    [titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.equalTo(@70);
        make.top.equalTo(@9);
        make.height.equalTo(@22);
    }];
}
- (IBAction)selectArchivePathAction:(id)sender {
    NSString * path = [GreatUserInterfaveControlPanel modalFilePanelUseDictionary:YES userFile:NO couldCreate:YES withTitle:@"请选择导出Archive文件包地址" okButton:@"确定"];
    if (path!=nil) {
        [self.archiveTextField setStringValue:path];
    }
}

- (IBAction)selectIpaPathAction:(id)sender {
    NSString * path = [GreatUserInterfaveControlPanel modalFilePanelUseDictionary:YES userFile:NO couldCreate:YES withTitle:@"请选择导出IPA安装包地址" okButton:@"确定"];
    if (path!=nil) {
        [self.ipaTextField setStringValue:path];
    }
}

- (IBAction)selectBuildModelAction:(NSPopUpButton *)sender {
    self.project.buildModel = self.buildModelSelectButton.indexOfSelectedItem+1;
    [self.modelTipLabel setStringValue:self.modelTipMessageArray[self.buildModelSelectButton.indexOfSelectedItem]];
    [[ProjectManager defaultManager]refreshProject:self.project];
    GUC_REFRESH(GUCMainView);
}
- (IBAction)selectIPATypeAction:(NSPopUpButton *)sender {
    NSString * type = @"ad-hoc";
    if (sender.indexOfSelectedItem==0) {
        type = @"app-store";
    }else if (sender.indexOfSelectedItem==1){
        type = @"ad-hoc";
    }else{
        type = @"development";
    }
    self.project.ipaType = type;
    [[ProjectManager defaultManager]refreshProject:self.project];
    GUC_REFRESH(GUCMainView);
}

- (IBAction)saveConfigurater:(NSButton *)sender {
    [self.schemeTextField abortEditing];
    self.project.archivePath = self.archiveTextField.stringValue;
    self.project.scheme = self.schemeTextField.stringValue;
    self.project.ipaPath = self.ipaTextField.stringValue;
    self.project.buildConfiguration = self.buildConfiguration.selectedItem.title;
    [[ProjectManager defaultManager]refreshProject:self.project];
    GUC_REFRESH(GUCMainView);
}

- (IBAction)saveUploadInfo:(NSButton *)sender {
    [self.uKeyField abortEditing];
    [self.apiKeyField abortEditing];
    [self.passwordField abortEditing];
    [self.uploadMessageLabel abortEditing];
    self.project.uKey = self.uKeyField.stringValue;
    self.project.api_key = self.apiKeyField.stringValue;
    self.project.password = self.passwordField.stringValue;
    self.project.updataMessage = self.uploadMessageLabel.stringValue;
    self.project.authority = [self.aothorityButton indexOfSelectedItem]+1;
    [[ProjectManager defaultManager]refreshProject:self.project];
    GUC_REFRESH(GUCMainView);
}


- (IBAction)startProject:(id)sender {
    NSString * error = nil;
    [self saveConfigurater:self.saveBuild];
    [self saveUploadInfo:self.savaUploadInfoButton];
    if ([self.project couldStartPeoject:&error]) {
        ProjectTask * task = self.currentProjectTask = [[XCBuildTaskManager defaultManager]createProjectTask:self.project];
        self.project.log = nil;
        self.logWindow.string = self.project.log;
        self.startButton.enabled = NO;
        self.stopButton.enabled = YES;
        [[XCBuildTaskManager defaultManager] runTask:task stepCallBack:^(int step, NSDictionary * error,CGFloat progress,NSString * log,NSString * info,BOOL isFinish) {
            [self.progressBar setDoubleValue:progress];
            if (error==nil) {
                NSString * logString = [NSString stringWithFormat:@"%@\n\n****\n****\n%@",self.project.log,log];
                NSString * finishString = [NSString stringWithFormat:@"\n===========\n===========%@已完成@^_^@\n",info];
                self.project.log = [NSString stringWithFormat:@"%@%@",logString,finishString];
            }else{
                NSString * logString = [NSString stringWithFormat:@"%@\n错误：\n!!!!\n!!!!\n%@",self.project.log,error];
                NSString * finishString = [NSString stringWithFormat:@"\n!!!!!!!!!!!\n!!!!!!!!!!!!%@发生错误：@#_#@\n",info];
                self.project.log = [NSString stringWithFormat:@"%@%@",logString,finishString];
            }
            self.logWindow.string = self.project.log;
            [self.logWindow scrollToEndOfDocument:nil];
            if (isFinish) {
                self.startButton.enabled = YES;
                self.stopButton.enabled = NO;
                self.currentProjectTask = nil;
            }
        }];
    }else{
        [GreatUserInterfaceControlAlert alertInWiondow:self.window withTitle:@"警告" message:error callBack:nil buttons:@"好的", nil];
    }
   
}

- (IBAction)stopProject:(id)sender {
    if (self.currentProjectTask) {
        [[XCBuildTaskManager defaultManager]cancelTask:self.currentProjectTask];
        self.currentProjectTask = nil;
    }
    
}

- (IBAction)seletedBranch:(NSPopUpButton *)sender {
    self.project.selectGitBranch = sender.selectedItem.title;
    [[ProjectManager defaultManager]refreshProject:self.project];
}

- (IBAction)refreshBranch:(NSButton *)sender {
    if (self.isRefreshingGitBranch) {
        return;
    }
    self.isRefreshingGitBranch = YES;
    self.refreshBranchTip.hidden = NO;
    [[XCBuildTaskManager defaultManager]getGitBranch:self.project stepCallBack:^(NSDictionary * error, NSString * des, BOOL finish) {
        self.isRefreshingGitBranch = NO;
        self.refreshBranchTip.hidden = YES;
        if (error!=nil) {
            NSString * logString = [NSString stringWithFormat:@"%@\n刷新分支错误错误：\n!!!!\n!!!!\n%@",self.project.log,error];
            self.project.log = logString;
            [[ProjectManager defaultManager]refreshProject:self.project];
        }
        NSArray * branchArray = [des componentsSeparatedByString:@"\r"];
        NSString * logString = [NSString stringWithFormat:@"%@\n刷新分支成功\n%@",self.project.log,des];
        self.project.log = logString;
        self.logWindow.string = self.project.log;
        [self.logWindow scrollToEndOfDocument:nil];
        [self.branchListButton removeAllItems];
        NSMutableArray * resArray = [[NSMutableArray alloc]init];
        for (int i=0; i<branchArray.count; i++) {
            NSString * strs = branchArray[i];
            strs = [strs substringFromIndex:2];//去空格与特殊字符
            [resArray addObject:strs];
            [self.branchListButton addItemWithTitle:strs];
        }
        self.project.gitBranchList =resArray;
        [[ProjectManager defaultManager]refreshProject:self.project];
    }];
}



-(void)updateViewWithModel:(ProjectModel *)model{
    self.project = model;
    [self.window.contentView setNeedsLayout:YES];
    [self.titleLabel setStringValue:model.projectName];
    [self.schemeTextField setStringValue:model.scheme];
    [self.archiveTextField setStringValue:model.archivePath];
    [self.buildConfiguration selectItemAtIndex:[model.buildConfiguration isEqualToString:@"Debug"]?0:1];
    [self.ipaTextField setStringValue:model.ipaPath];
    [self.buildModelSelectButton selectItemAtIndex:model.buildModel-1];
    self.logWindow.string = model.log;
    [self.logWindow scrollToEndOfDocument:nil];
    self.startButton.enabled = YES;
    self.stopButton.enabled = NO;
    int index = 0;
    if ([model.ipaType isEqualToString:@"ad-hoc"]) {
        index = 1;
    }else if ([model.ipaType isEqualToString:@"app-store"]){
        index = 0;
    }else{
        index = 2;
    }
    [self.ipaTypeButton selectItemAtIndex:index];
    [self.modelTipLabel setStringValue:self.modelTipMessageArray[model.buildModel-1]];
    for (ProjectTask * task in [XCBuildTaskManager defaultManager].allRuningProjectTask) {
        if ([task.projectPath isEqualToString:model.projectPath]) {
            self.startButton.enabled = NO;
            self.stopButton.enabled = YES;
        }
    }
    
    //.git file exist?
    [self updateGitTip:[[NSFileManager defaultManager] fileExistsAtPath:model.gitFilePath]];
    
    [self.branchListButton removeAllItems];
    for (int i =0; i<model.gitBranchList.count; i++) {
        [self.branchListButton addItemWithTitle:model.gitBranchList[i]];
    }
    [self.branchListButton selectItemWithTitle:model.selectGitBranch];
    [self.refreshBranchTip startAnimation:nil];
    self.refreshBranchTip.hidden = !self.isRefreshingGitBranch;
    
    //upload
    [self.uKeyField setStringValue:model.uKey];
    [self.apiKeyField setStringValue:model.api_key];
    [self.aothorityButton selectItemAtIndex:model.authority-1];
    [self.passwordField setStringValue:model.password];
    [self.uploadMessageLabel setStringValue:model.updataMessage];
}

#pragma mark -- innder
-(void)updateGitTip:(BOOL)able{
    if (!able) {
        self.gitUnableTipOne.hidden = NO;
        self.gitUnableTipTwo.hidden = NO;
        self.gitContentView.hidden = YES;
    }else{
        self.gitUnableTipOne.hidden = YES;
        self.gitUnableTipTwo.hidden = YES;
        self.gitContentView.hidden = NO;
    }
}


#pragma mark -- setter and getter
-(NSArray *)modelTipMessageArray{
    if (!_modelTipMessageArray) {
        _modelTipMessageArray = @[MODEL_USER_WONER_TIP,MODEL_SEMI_AUTO_TIP,MODEL_AOTU_TIP];
    }
    return _modelTipMessageArray;
}

@end
