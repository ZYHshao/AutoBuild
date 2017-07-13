//
//  UploadTask.m
//  AutoBuildApp
//
//  Created by jaki on 2017/7/10.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "UploadTask.h"
#import "HttpRequestManager.h"
#import "ProjectModel.h"

@interface UploadTask()

@property(nonatomic,weak)ProjectModel * project;

@end


@implementation UploadTask
-(instancetype)initWithProject:(ProjectModel *)project {
    self = [super init];
    if (self) {
        self.mode = BaseTaskiInnerTask;
        self.project = project;
        self.taskInfo = @"上传ipa包到蒲公英";
    }
    return self;
}

-(void)innerTask:(void (^)(id, BOOL, CGFloat))taskInfoCallback{
    NSString * ukey = self.project.uKey;
    NSString * apikey = self.project.api_key;
    NSInteger installType = self.project.authority;
    NSString * password = @"";
    if (installType!=DownLoadAuthorityPublic) {
        password = self.project.password;
    }
    NSString * description = self.project.updataMessage;
    NSDictionary * params = @{@"uKey":ukey,@"_api_key":apikey,@"installType":@(installType),@"password":password,@"updateDescription":description};
    [[HttpRequestManager defaultManager]uploadFile:[NSString stringWithFormat:@"%@/%@/%@.ipa",self.project.ipaPath,self.project.projectName,self.project.projectName] params:params conpletion:^(id response,CGFloat progress) {
        if ((NSInteger)progress == 1) {
            taskInfoCallback(response,YES,1);
        }else{
            taskInfoCallback(nil,NO,progress);
        }
        
    }];
}
@end
