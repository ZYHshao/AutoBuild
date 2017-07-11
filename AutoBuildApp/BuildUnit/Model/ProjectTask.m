//
//  ProjectTask.m
//  AutoBuildApp
//
//  Created by jaki on 2017/6/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

#import "ProjectTask.h"
#import "ProjectModel.h"
#import "XCBuildTask.h"
#import "GitTask.h"
#import "UploadTask.h"

@interface ProjectTask()

@property (nonatomic,weak)ProjectModel * project;

@end

@implementation ProjectTask

-(instancetype)initWithProject:(ProjectModel *)project{
    self = [super init];
    if (self) {
        self.project = project;
        _projectPath = project.projectPath;
        
    }
    return self;
}

-(NSArray<BaseTask*> *)createTaskGroup{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    if (self.project.buildModel == ProjectUserOwnerModel) {
        XCBuildTask * taskClean = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeClean];
        XCBuildTask * taskArchive = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeExportArchive];
        XCBuildTask * taskIPA = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeExportIPA];
        [array addObject:taskClean];
        [array addObject:taskArchive];
        [array addObject:taskIPA];
        self.totalTask = 3;
    }else if(self.project.buildModel == ProjectSemiAuto){
//        XCBuildTask * taskClean = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeClean];
//        XCBuildTask * taskArchive = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeExportArchive];
//        XCBuildTask * taskIPA = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeExportIPA];
        UploadTask * taskUpload = [[UploadTask alloc]initWithProject:self.project];
//        [array addObject:taskClean];
//        [array addObject:taskArchive];
//        [array addObject:taskIPA];
        [array addObject:taskUpload];
        self.totalTask = 1;
    }else if(self.project.buildModel == ProjectAuto){
        GitTask * checkout = [[GitTask alloc]initWithProject:self.project taskType:GitTaskTypeCheckOut];
        GitTask * pullTask = [[GitTask alloc]initWithProject:self.project taskType:GitTaskTypePull];
        XCBuildTask * taskClean = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeClean];
        XCBuildTask * taskArchive = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeExportArchive];
        XCBuildTask * taskIPA = [[XCBuildTask alloc]initWithProject:self.project taskType:XCBuildTaskTypeExportIPA];
        UploadTask * taskUpload = [[UploadTask alloc]initWithProject:self.project];
        [array addObject:checkout];
        [array addObject:pullTask];
        [array addObject:taskClean];
        [array addObject:taskArchive];
        [array addObject:taskIPA];
        [array addObject:taskUpload];
        self.totalTask = 6;
    }
    return array;
}

-(BaseTask *)createTaskGetGitBranch{
    GitTask * task = [[GitTask alloc]initWithProject:self.project taskType:GitTaskTypeGetBranchList];
    return task;
}

@end
