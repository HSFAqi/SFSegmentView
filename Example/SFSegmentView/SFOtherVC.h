//
//  SFOtherVC.h
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/19.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <SFSegmentView/SFSegmentView.h>
NS_ASSUME_NONNULL_BEGIN

@interface SFOtherVC : UIViewController

@property (nonatomic,strong) SFSegmentConfig *config;
@property (nonatomic,copy) void (^changedBlock)(SFSegmentConfig *config);

@end

NS_ASSUME_NONNULL_END
