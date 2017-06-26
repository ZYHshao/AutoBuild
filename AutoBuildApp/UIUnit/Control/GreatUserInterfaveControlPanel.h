//
//  GreatUserInterfaveControlPanel.h
//  AutoBuildApp
//
//  Created by jaki on 2017/6/26.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface GreatUserInterfaveControlPanel : NSObject

+(NSString*)modalFilePanelUseDictionary:(BOOL)dic userFile:(BOOL)file couldCreate:(BOOL)canCreate withTitle:(NSString *)title okButton:(NSString *)ok;

@end
