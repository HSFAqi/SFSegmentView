//
//  SFSegmentView.h
//  PodTestDemo
//
//  Created by 黄山锋 on 2019/10/12.
//  Copyright © 2019 黄山锋. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SFSegmentConfig.h"


NS_ASSUME_NONNULL_BEGIN

@interface SFSegmentView : UIView

@property (nonatomic,strong) SFSegmentConfig *config;
@property (nonatomic,strong) NSArray *contents;
@property (nonatomic,copy) void (^didSelectedItemBlock)(NSInteger index);

// 推荐
- (instancetype)initWithConfig:(nullable SFSegmentConfig *)config frame:(CGRect)frame;
+ (instancetype)segmentViewWithConfig:(nullable SFSegmentConfig *)config frame:(CGRect)frame;

/* move action */
// 向前移动
- (void)moveForward;
// 向后移动
- (void)moveBackward;
// 移动到指定位置
- (void)moveTo:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
