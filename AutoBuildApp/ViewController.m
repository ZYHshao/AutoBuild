//
//  ViewController.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ViewController.h"
@interface ViewController()

@property (weak) IBOutlet NSView *topBarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self installView];
}

-(void)installView{
    self.topBarView.wantsLayer = YES;
    self.topBarView.layer.backgroundColor = [NSColor colorWithRed:33.0/255.0 green:176.0/255.0 blue:275.0/255.0 alpha:1].CGColor;
    [self.topBarView setNeedsDisplay:YES];
    [self.topBarView displayIfNeeded];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
