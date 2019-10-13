//
//  SFSegmentConfig.h
//  PodTestDemo
//
//  Created by 黄山锋 on 2019/10/12.
//  Copyright © 2019 黄山锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 内容样式
typedef NS_ENUM(NSInteger, SFSegmentContentStyle) {
    SFSegmentContentStyleFont = 0, // 纯文本
    SFSegmentContentStyleImage // 图片
};

// 指示器方向
typedef NS_ENUM(NSInteger, SFSegmentIndicatorDir) {
    SFSegmentIndicatorDirBottom = 0,
    SFSegmentIndicatorDirTop
};

// 指示器样式
typedef NS_ENUM(NSInteger, SFSegmentIndicatorStyle) {
    SFSegmentIndicatorStyleNone = 0,
    SFSegmentIndicatorStyleLine,
    SFSegmentIndicatorStyleSquare,
    SFSegmentIndicatorStyleArrow,
    SFSegmentIndicatorStyleDot
};


@interface SFSegmentConfig : NSObject

@property (nonatomic,assign) SFSegmentContentStyle contentStyle;
@property (nonatomic,assign) SFSegmentIndicatorStyle indicatorStyle;
@property (nonatomic,assign) SFSegmentIndicatorDir indicatorDir;
@property (nonatomic,assign) NSInteger defaultIndex;
@property (nonatomic,assign) BOOL isAnimated;
// 分割线（默认无）
@property (nonatomic,assign) BOOL isHaveSeparator;
@property (nonatomic,strong) UIColor *separatorColor;
@property (nonatomic,assign) CGFloat separatorHeight;



//-------------------------
/* 内容样式 */
/**
 * 样式一：font
 */
@property (nonatomic,strong) UIColor *fontColor_nor;
@property (nonatomic,strong) UIColor *fontColor_sel;
@property (nonatomic,assign) CGFloat fontSize;
/**
 * 样式二：image
 * 说明：image_nor/image_sel 的值是icon名称后面的[标志字符]
 * 比如：给SFSegmentView的实例对象的contents属性赋值，
 * 在将数组内的元素icon赋值给image前，会自动给该元素icon后面拼接[标志字符]
 * 分别生成icon_nor和icon_sel
 */
@property (nonatomic,strong) NSString *image_nor;
@property (nonatomic,strong) NSString *image_sel;


//-------------------------
/* 指示器样式 */
// 样式一：none
// 样式二：line
@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,assign) CGSize lineSize;
// 样式三：square
@property (nonatomic,strong) UIColor *squareColor;
@property (nonatomic,assign) UIEdgeInsets squareEdgeInsert;
@property (nonatomic,assign) CGFloat squareCornerRadius;
// 样式四：arrow
@property (nonatomic,strong) UIColor *arrowColor;
@property (nonatomic,assign) CGSize arrowSize;
// 样式五：dot
@property (nonatomic,strong) UIColor *dotColor;
@property (nonatomic,assign) CGSize dotSize;



+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
