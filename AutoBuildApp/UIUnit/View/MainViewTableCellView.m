//
//  MainViewTableCellView.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "MainViewTableCellView.h"
#import "ColorView.h"

@interface MainViewTableCellView()

@property (weak) IBOutlet NSTextField *logoLabel;
@property (weak) IBOutlet ColorView *bottonLine;
@property (weak) IBOutlet NSTextField *titleLabel;

@end

@implementation MainViewTableCellView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self installUI];
}

-(void)installUI{
    self.bottonLine.backgroundColor = [NSColor colorWithWhite:0.5 alpha:0.5];
    [self.bottonLine setNeedsDisplay:YES];
    [self.logoLabel setWantsLayer:YES];
    self.logoLabel.layer.masksToBounds = YES;
    self.logoLabel.layer.cornerRadius = 20;
}

-(void)updateViewWithModel:(MainViewTableCellModel *)model{
    self.logoLabel.layer.backgroundColor = [NSColor colorWithRed:((arc4random()%200)+55.0)/255.0 green:((arc4random()%200)+55.0)/255.0 blue:((arc4random()%200)+55.0)/255.0 alpha:1].CGColor;
    [self.logoLabel setStringValue:[model.title substringToIndex:1]];
    [self.titleLabel setStringValue:model.title];
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end
