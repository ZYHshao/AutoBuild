//
//  HttpRequestManager.h
//  AutoBuildApp
//
//  Created by jaki on 2017/7/10.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UploadFileCompleted)(id response,CGFloat progress);

@interface HttpRequestManager : NSObject

+(instancetype)defaultManager;

-(void)uploadFile:(NSString*)filePath params:(NSDictionary *)paramsDic conpletion:(UploadFileCompleted)completed;

@end
