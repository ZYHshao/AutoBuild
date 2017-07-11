

//
//  HttpRequestManager.m
//  AutoBuildApp
//
//  Created by jaki on 2017/7/10.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "HttpRequestManager.h"
#import <AFNetworking/AFNetworking.h>

@interface HttpRequestManager()

@property(nonatomic,strong)AFURLSessionManager * manager;

@property(nonatomic,strong)NSURLRequest * request;

@end

@implementation HttpRequestManager

+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static HttpRequestManager * manager = nil;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[HttpRequestManager alloc]init];
        }
    });
    return manager;
}

-(void)uploadFile:(NSString *)filePath params:(NSDictionary *)paramsDic conpletion:(UploadFileCompleted)completed{
    self.request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:@"https://qiniu-storage.pgyer.com/apiv1/app/upload" parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"VSVipUnion.ipa" mimeType:@"application/octet-stream" error:nil];
    } error:nil];
    [[self.manager uploadTaskWithStreamedRequest:self.request progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"总：%lld",uploadProgress.totalUnitCount);
        NSLog(@"完成：%lld",uploadProgress.completedUnitCount);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        completed(responseObject,1);
    }] resume];
}

#pragma mark -- setter and getter
-(AFURLSessionManager *)manager{
    if (!_manager) {
        _manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _manager;
}

@end
