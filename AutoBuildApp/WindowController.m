//
//  WindowController.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "WindowController.h"
#import <Masonry/Masonry.h>

@interface WindowController ()

@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self remakeTitleBar];
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

@end
