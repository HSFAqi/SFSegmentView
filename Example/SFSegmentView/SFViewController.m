//
//  SFViewController.m
//  SFSegmentView
//
//  Created by hsfiOSGitHub on 10/12/2019.
//  Copyright (c) 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFViewController.h"

#import <SFSegmentView/SFSegmentView.h>
#import "SFContentVC.h"
#import "SFIndicatorVC.h"
#import "SFOtherVC.h"

@interface SFViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) NSArray *contents;
@property (nonatomic,strong) SFSegmentConfig *config;
@property (nonatomic,strong) SFSegmentView *segmentView;
@property (weak, nonatomic) IBOutlet SFSegmentView *xibSegmentView;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) SFSegmentView *settingSegmentView;
@property (nonatomic,strong) SFContentVC *contentVC;
@property (nonatomic,strong) SFIndicatorVC *indicatorVC;
@property (nonatomic,strong) SFOtherVC *otherVC;



@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"测试";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.config = [SFSegmentConfig defaultConfig];
    self.contents = @[@"签约项目", @"护理项目", @"其他项目", @"签约项目", @"护理项目", @"其他项目", @"签约项目", @"护理项目", @"其他项目", @"签约项目", @"护理项目", @"其他项目"];
    /* 代码方式创建 */
    // 方式1：
//    self.segmentView = [[SFSegmentView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 44)];
//    self.segmentView.config = self.config;
    
    // 方式2：
    //self.segmentView = [SFSegmentView segmentViewWithConfig:self.config frame:CGRectMake(0, 30, self.view.frame.size.width, 44)];
    
    // 方式3：
    self.segmentView = [[SFSegmentView alloc]initWithConfig:self.config frame:CGRectMake(0, 30, self.view.frame.size.width, 44)];
    
    self.segmentView.backgroundColor = [UIColor whiteColor];
    self.segmentView.contents = self.contents;
    [self.view addSubview:self.segmentView];

    
    /* XIB方式创建 */
    self.xibSegmentView.config = self.config;
    self.xibSegmentView.contents = self.contents;
    
    
    [self setting];
}

- (void)setting{
    CGFloat topHeight = [UIApplication sharedApplication].statusBarFrame.size.height+44;
    CGFloat viewHeight = self.view.frame.size.height-topHeight;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 210, self.view.frame.size.width, viewHeight-210)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*3, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    typeof(self) weakSelf = self;
    
    self.contentVC = [[SFContentVC alloc]init];
    self.contentVC.config = self.config;
    self.contentVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self addChildViewController:self.contentVC];
    [self.scrollView addSubview:self.contentVC.view];
    self.contentVC.changedBlock = ^(SFSegmentConfig * _Nonnull config) {
        [weakSelf changedAction:config];
    };
    
    self.indicatorVC = [[SFIndicatorVC alloc]init];
    self.indicatorVC.config = self.config;
    self.indicatorVC.view.frame = CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self addChildViewController:self.indicatorVC];
    [self.scrollView addSubview:self.indicatorVC.view];
    self.indicatorVC.changedBlock = ^(SFSegmentConfig * _Nonnull config) {
        [weakSelf changedAction:config];
    };
    
    self.otherVC = [[SFOtherVC alloc]init];
    self.otherVC.config = self.config;
    self.otherVC.view.frame = CGRectMake(self.scrollView.frame.size.width*2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self addChildViewController:self.otherVC];
    [self.scrollView addSubview:self.otherVC.view];
    self.otherVC.changedBlock = ^(SFSegmentConfig * _Nonnull config) {
        [weakSelf changedAction:config];
    };
    
    
    
    
    SFSegmentConfig *config = [SFSegmentConfig defaultConfig];
    config.isHaveSeparator = YES;
    config.separatorHeight = 20;
    self.settingSegmentView = [[SFSegmentView alloc]initWithConfig:config frame:CGRectMake(20, viewHeight-60, self.view.frame.size.width-40, 40)];
    self.settingSegmentView.contents = @[@"内容", @"指示器", @"其他"];
    self.settingSegmentView.backgroundColor = [UIColor whiteColor];
    self.settingSegmentView.clipsToBounds = NO;
    self.settingSegmentView.layer.cornerRadius = 20;
    self.settingSegmentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.settingSegmentView.layer.borderWidth = 1;
    self.settingSegmentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.settingSegmentView.layer.shadowOffset = CGSizeMake(4, 4);
    self.settingSegmentView.layer.shadowOpacity = 0.3;
    [self.view addSubview:self.settingSegmentView];
    
    self.settingSegmentView.didSelectedItemBlock = ^(NSInteger index) {
        [weakSelf.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*index, 0) animated:YES];
    };
}
- (void)changedAction:(SFSegmentConfig *)config{
    self.config = config;
    self.segmentView.contents = self.contents;
    self.xibSegmentView.contents = self.contents;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
