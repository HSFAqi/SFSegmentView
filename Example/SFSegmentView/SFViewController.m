//
//  SFViewController.m
//  SFSegmentView
//
//  Created by hsfiOSGitHub on 10/12/2019.
//  Copyright (c) 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFViewController.h"

#import <SFSegmentView/SFSegmentView.h>

@interface SFViewController ()

@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"测试";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    SFSegmentConfig *config = [SFSegmentConfig defaultConfig];
    config.indicatorStyle = SFSegmentIndicatorStyleDot;
    SFSegmentView *segmentView = [SFSegmentView segmentViewWithConfig:config frame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    segmentView.backgroundColor = [UIColor whiteColor];
    segmentView.contents = @[@"签约项目", @"护理项目", @"其他项目"];
    [self.view addSubview:segmentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
