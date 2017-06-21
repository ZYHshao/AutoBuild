//
//  MainViewTableCellView.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewTableCellModel.h"

@interface MainViewTableCellView : NSTableCellView

-(void)updateViewWithModel:(MainViewTableCellModel *)model;

@end
