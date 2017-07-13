//
//  GreatUserInterfaveControlPanel.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/26.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "GreatUserInterfaveControlPanel.h"

@implementation GreatUserInterfaveControlPanel

+(NSString*)modalFilePanelUseDictionary:(BOOL)dic userFile:(BOOL)file couldCreate:(BOOL)canCreate withTitle:(NSString *)title okButton:(NSString *)ok{
    NSOpenPanel * panel = [NSOpenPanel openPanel];
    [panel setMessage:title];
    [panel setPrompt:ok];
    [panel setCanChooseDirectories:dic];//是否可选择目录
    [panel setCanCreateDirectories:canCreate];//是否可创建目录
    [panel setCanChooseFiles:file];//是否可选择文件
    NSString * path = nil;
    NSInteger result = [panel runModal];
    if (result == NSFileHandlingPanelOKButton) {
        path = [panel URL].path;
    }
    return path;
}

@end
