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

@interface ProjectDetailWindow ()
@property (weak) IBOutlet NSTextField *titleLabel;


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

-(void)updateViewWithModel:(ProjectModel *)model{
    [self.window.contentView setNeedsLayout:YES];
    [self.titleLabel setStringValue:model.projectName];
}


@end
