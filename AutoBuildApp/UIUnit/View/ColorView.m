//
//  ColorView.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView





- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [self.backgroundColor set];
    NSRectFill(dirtyRect);
}

@end
