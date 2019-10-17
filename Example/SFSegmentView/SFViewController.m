//
//  SFViewController.m
//  SFSegmentView
//
//  Created by hsfiOSGitHub on 10/12/2019.
//  Copyright (c) 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFViewController.h"

#import <SFSegmentView/SFSegmentView.h>

@interface SFViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) NSArray *contents;
@property (nonatomic,strong) SFSegmentConfig *config;
@property (nonatomic,strong) SFSegmentView *segmentView;

@property (weak, nonatomic) IBOutlet UITextField *indexTextField;
@property (weak, nonatomic) IBOutlet SFSegmentView *xibSegmentView;

@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"测试";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //self.contents = @[@"签约项目", @"护理项目", @"其他项目", @"签约项目", @"护理项目", @"其他项目", @"签约项目", @"护理项目", @"其他项目", @"签约项目", @"护理项目", @"其他项目"];
    //self.contents = @[@"签约项目", @"护理项目", @"其他项目"];
    self.contents = @[@"签", @"签", @"签", @"签", @"签", @"签", @"签", @"签"];
    self.config = [SFSegmentConfig defaultConfig];
    self.config.contentWidthStyle = SFSegmentContentWidthStyleEqualMax;
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
    typeof(self) weakSelf = self;
    self.segmentView.didSelectedItemBlock = ^(NSInteger index) {
        weakSelf.indexTextField.text = [NSString stringWithFormat:@"%ld",(long)index];
    };
    
    /* XIB方式创建 */
    self.xibSegmentView.config = self.config;
    self.xibSegmentView.contents = self.contents;
    
    
    // 键盘
    self.indexTextField.delegate = self;
    UIView *inputAccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    inputAccessoryView.backgroundColor = [UIColor whiteColor];
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBtn setTitle:@"GO" forState:UIControlStateNormal];
    [goBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [goBtn addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    goBtn.frame = CGRectMake(self.view.frame.size.width-100, 0, 100, 40);
    [inputAccessoryView addSubview:goBtn];
    self.indexTextField.inputAccessoryView = inputAccessoryView;
    
}

#pragma mark goAction
-(void)goAction{
    [self.indexTextField resignFirstResponder];
    [self.segmentView moveTo:self.indexTextField.text.integerValue];
    [self.xibSegmentView moveTo:self.indexTextField.text.integerValue];
}

#pragma mark action
// 内容样式
- (IBAction)changeContentStyle:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.config.contentStyle = SFSegmentContentStyleFont;
            break;
            
        case 1:
            self.config.contentStyle = SFSegmentContentStyleImage;
            break;
            
        case 2:
            self.config.contentStyle = SFSegmentContentStyleIcon;
            break;
            
        default:
            break;
    }
    [self reload];
}
// 指示器样式
- (IBAction)changeIndicatorStyle:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.config.indicatorStyle = SFSegmentIndicatorStyleNone;
            break;
            
        case 1:
            self.config.indicatorStyle = SFSegmentIndicatorStyleLine;
            break;
            
        case 2:
            self.config.indicatorStyle = SFSegmentIndicatorStyleSquare;
            break;
                
            
        case 3:
            self.config.indicatorStyle = SFSegmentIndicatorStyleArrow;
            break;
            
        case 4:
            self.config.indicatorStyle = SFSegmentIndicatorStyleDot;
            break;
            
        default:
            break;
    }
    [self reload];
}
//指示器方向
- (IBAction)changeIndicatorDir:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.config.indicatorDir = SFSegmentIndicatorDirBottom;
            break;
            
        case 1:
            self.config.indicatorDir = SFSegmentIndicatorDirTop;
            break;
            
        default:
            break;
    }
    [self reload];
}
//指示器动画
- (IBAction)changeIndecatorAnimation:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.config.isAnimated = NO;
            break;
            
        case 1:
            self.config.isAnimated = YES;
            break;
            
        default:
            break;
    }
    [self reload];
}
//分割线
- (IBAction)changeSeparator:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.config.isHaveSeparator = NO;
            break;
            
        case 1:
            self.config.isHaveSeparator = YES;
            break;
            
        default:
            break;
    }
    [self reload];
}
//移动
- (IBAction)moveAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self.segmentView moveBackward];
            [self.xibSegmentView moveBackward];
            break;
            
        case 1:
            [self.segmentView moveForward];
            [self.xibSegmentView moveForward];
            break;
            
        default:
            break;
    }
}

#pragma mark reload
- (void)reload{
    self.segmentView.contents = self.contents;
    self.xibSegmentView.contents = self.contents;
}


#pragma mark UITextFieldDelegate



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
