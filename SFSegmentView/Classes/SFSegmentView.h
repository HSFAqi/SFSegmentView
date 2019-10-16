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

/** 样式配置 */
@property (nonatomic,strong) SFSegmentConfig *config;
/** 内容数组 */
@property (nonatomic,strong) NSArray *contents;
/** 选中item回调 */
@property (nonatomic,copy) void (^didSelectedItemBlock)(NSInteger index);


// MARK: - initialize
- (instancetype)initWithConfig:(nullable SFSegmentConfig *)config frame:(CGRect)frame;
+ (instancetype)segmentViewWithConfig:(nullable SFSegmentConfig *)config frame:(CGRect)frame;


// MARK: - move action
/// 向前移动
- (void)moveForward;
/// 向后移动
- (void)moveBackward;
/// 移动到指定位置
- (void)moveTo:(NSInteger)index;



@end

NS_ASSUME_NONNULL_END
