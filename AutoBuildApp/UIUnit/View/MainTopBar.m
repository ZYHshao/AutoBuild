//
//  MainTopBar.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "MainTopBar.h"

@implementation MainTopBar

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSColor colorWithRed:33.0/255.0 green:176.0/255.0 blue:275.0/255.0 alpha:1] set];
     NSRectFill(dirtyRect);
}

@end
