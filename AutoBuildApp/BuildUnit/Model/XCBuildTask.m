//
//  XCBuildTask.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "XCBuildTask.h"
#import "ProjectModel.h"

#define SCRIPT_FORMAT_STRING_CLEAN @"do shell script \"xcodebuild clean -%@ %@ -scheme %@ CONFIGURATION=%@\""

#define SCRIPT_FORMAT_STRING_ARCHIVE @"do shell script \"xcodebuild archive -%@ %@ -scheme %@ -archivePath %@/%@ CONFIGURATION=%@\""

#define SCRIPT_FORMAT_STRING_IPA @"do shell script \"xcodebuild -exportArchive -archivePath %@/%@.xcarchive -exportPath %@/%@ -exportOptionsPlist %@\""

@interface XCBuildTask()

@property(nonatomic,weak)ProjectModel * project;
@property(nonatomic,assign)XCBuildTaskType type;

@end


@implementation XCBuildTask

-(instancetype)initWithProject:(ProjectModel *)project taskType:(XCBuildTaskType)taskType{
    self = [super init];
    if (self) {
        self.type = taskType;
        self.project = project;
        [self createFormatStringAndInfo];
    }
    return self;
}

-(void)createFormatStringAndInfo{
    if (self.type == XCBuildTaskTypeClean) {
        self.scriptFormat = [NSString stringWithFormat:SCRIPT_FORMAT_STRING_CLEAN,self.project.projectType,self.project.projectPath,self.project.scheme,self.project.buildConfiguration];
        self.taskInfo = @"clean工程";
    }else if (self.type == XCBuildTaskTypeExportArchive){
        self.taskInfo = @"导出Archive文件";
        self.scriptFormat = [NSString stringWithFormat:SCRIPT_FORMAT_STRING_ARCHIVE,self.project.projectType,self.project.projectPath,self.project.scheme,self.project.archivePath,self.project.projectName,self.project.buildConfiguration];
        
    }else if (self.type == XCBuildTaskTypeExportIPA){
        self.taskInfo = @"导出IPA安装包";
        self.scriptFormat = [NSString stringWithFormat:SCRIPT_FORMAT_STRING_IPA,self.project.archivePath,self.project.projectName,self.project.ipaPath,self.project.projectName,[self getPlist]];
    }else{
        self.scriptFormat = @"";
    }
}

-(NSString *)getPlist{
    NSString * type = self.project.ipaType;
    NSDictionary * dic = @{@"compileBitcode":@NO,
                            @"method":type};
    [dic writeToFile:[NSString stringWithFormat:@"%@/config.plist",self.project.archivePath] atomically:NO];
    return [NSString stringWithFormat:@"%@/config.plist",self.project.archivePath];
}

@end
