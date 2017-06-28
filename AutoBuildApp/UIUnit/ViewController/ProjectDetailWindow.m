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

@interface ProjectDetailWindow ()

@property (nonatomic,strong)ProjectModel * project;

@property (weak) IBOutlet NSTextField *titleLabel;


//MARK: build
@property (weak) IBOutlet NSTextField *schemeTextField;
@property (weak) IBOutlet NSTextField *archiveTextField;
@property (weak) IBOutlet NSPopUpButton *buildConfiguration;
@property (weak) IBOutlet NSTextField *ipaTextField;
@property (weak) IBOutlet NSButton *selectArchivePath;
@property (weak) IBOutlet NSButton *selectIpaPath;
@property (weak) IBOutlet NSButton *saveBuild;

//MARK: Normal
@property (weak) IBOutlet NSPopUpButton *buildModelSelectButton;
@property (unsafe_unretained) IBOutlet NSTextView *logWindow;

@property (weak) IBOutlet NSButton *startButton;
@property (weak) IBOutlet NSButton *stopButton;


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

- (IBAction)startProject:(id)sender {
   ProjectTask * task = [[XCBuildTaskManager defaultManager]createProjectTask:self.project];
    [[XCBuildTaskManager defaultManager] runTask:task stepCallBack:^(int step, NSDictionary * error) {
        NSLog(@"%d,%@",step,error);
    }];
}

- (IBAction)stopProject:(id)sender {
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
    self.startButton.enabled = YES;
    self.stopButton.enabled = NO;
    for (ProjectTask * task in [XCBuildTaskManager defaultManager].allRuningProjectTask) {
        if ([task.projectPath isEqualToString:model.projectPath]) {
            self.startButton.enabled = NO;
            self.stopButton.enabled = YES;
        }
    }
}


@end
