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

//------------内容-------------//
/**
 * 内容样式
 */
typedef NS_ENUM(NSInteger, SFSegmentContentStyle) {
    SFSegmentContentStyleFont = 0,  // 纯文本
    SFSegmentContentStyleImage,     // 图片
    SFSegmentContentStyleIcon       // icon（使用tintColor）
};

/**
 * 内容宽度样式
 */
typedef NS_ENUM(NSInteger, SFSegmentContentWidthStyle) {
    SFSegmentContentWidthStyleEqual = 0,  // 等宽，取最长的文本宽度
    SFSegmentContentWidthStyleAuto        // 根据文本自动计算宽度
};

/**
 * 内容对齐方式
 * 说明：内容的对齐方式，只针对于item总宽度<父view的宽度 的情况
 */
typedef NS_ENUM(NSInteger, SFSegmentContentAlignment) {
    SFSegmentContentAlignmentLeft = 0,  // 左对齐
    SFSegmentContentAlignmentRight      // 右对齐
};


//------------指示器-------------//
// 指示器样式
typedef NS_ENUM(NSInteger, SFSegmentIndicatorStyle) {
    SFSegmentIndicatorStyleNone = 0,
    SFSegmentIndicatorStyleLine,
    SFSegmentIndicatorStyleSquare,
    SFSegmentIndicatorStyleArrow,
    SFSegmentIndicatorStyleDot
};
// 指示器方向
typedef NS_ENUM(NSInteger, SFSegmentIndicatorDir) {
    SFSegmentIndicatorDirBottom = 0,
    SFSegmentIndicatorDirTop
};


@interface SFSegmentConfig : NSObject


/** 内容样式 */
@property (nonatomic,assign) SFSegmentContentStyle contentStyle;
/** 内容对齐方式 */
@property (nonatomic,assign) SFSegmentContentAlignment contentAlignment;
/** 内容宽度样式 */
@property (nonatomic,assign) SFSegmentContentWidthStyle contentWidthStyle;
/** 指示器样式 */
@property (nonatomic,assign) SFSegmentIndicatorStyle indicatorStyle;
/** 指示器方向 */
@property (nonatomic,assign) SFSegmentIndicatorDir indicatorDir;
/** 默认选中index */
@property (nonatomic,assign) NSInteger defaultIndex;
/** 是否有动画（指示器） */
@property (nonatomic,assign) BOOL isAnimated;
/** 是否有分割线 */
@property (nonatomic,assign) BOOL isHaveSeparator;
/** 分割线颜色 */
@property (nonatomic,strong) UIColor *separatorColor;
/** 分割线高度 */
@property (nonatomic,assign) CGFloat separatorHeight;



// MARK: - 内容样式相关属性
// 样式一：font
/** 字体默认颜色 */
@property (nonatomic,strong) UIColor *fontColor_nor;
/** 字体选中颜色 */
@property (nonatomic,strong) UIColor *fontColor_sel;
/** 字体大小 */
@property (nonatomic,assign) CGFloat fontSize;


// 样式二：image
/*
 说明：image_nor/image_sel 的值是icon名称后面的[标志字符]
 比如：给SFSegmentView的实例对象的contents属性赋值，
 在将数组内的元素icon赋值给image前，会自动给该元素icon后面拼接[标志字符]
 分别生成icon_nor和icon_sel
 */
/** 默认image */
@property (nonatomic,strong) NSString *image_nor;
/** 选中image */
@property (nonatomic,strong) NSString *image_sel;


// 样式三：icon（使用tintcolor）
/** icon默认颜色 */
@property (nonatomic,strong) UIColor *iconTintColor_nor;
/** icon选中颜色 */
@property (nonatomic,strong) UIColor *iconTintColor_sel;


// MARK: - 指示器样式相关属性
// 样式一：none


// 样式二：line
/** 指示器（line）颜色 */
@property (nonatomic,strong) UIColor *lineColor;
/** 指示器（line）size */
@property (nonatomic,assign) CGSize lineSize;


// 样式三：square
/** 指示器（square）颜色 */
@property (nonatomic,strong) UIColor *squareColor;
/** 指示器（square）缩进 */
@property (nonatomic,assign) UIEdgeInsets squareEdgeInsert;
/** 指示器（square）圆角大小 */
@property (nonatomic,assign) CGFloat squareCornerRadius;


// 样式四：arrow
/** 指示器（arrow）颜色 */
@property (nonatomic,strong) UIColor *arrowColor;
/** 指示器（arrow）size */
@property (nonatomic,assign) CGSize arrowSize;


// 样式五：dot
/** 指示器（dot）颜色 */
@property (nonatomic,strong) UIColor *dotColor;
/** 指示器（dot）大小 */
@property (nonatomic,assign) CGSize dotSize;


// MARK: - 默认配置
+ (instancetype)defaultConfig;




@end

NS_ASSUME_NONNULL_END
