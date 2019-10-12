//
//  SFSegmentConfig.m
//  PodTestDemo
//
//  Created by 黄山锋 on 2019/10/12.
//  Copyright © 2019 黄山锋. All rights reserved.
//

#import "SFSegmentConfig.h"

@implementation SFSegmentConfig

+ (instancetype)defaultConfig{
    SFSegmentConfig *config = [[SFSegmentConfig alloc]init];
    
    config.contentStyle = SFSegmentContentStyleFont;
    config.indicatorDir = SFSegmentIndicatorDirBottom;
    config.indicatorStyle = SFSegmentIndicatorStyleLine;
    config.defaultIndex = 0;
    config.isAnimated = NO;
    
    // 分割线
    config.isHaveSeparator = NO;
    config.separatorColor = [UIColor lightGrayColor];
    config.separatorHeight = 30;
    
    // 内容样式
    switch (config.contentStyle) {
        case SFSegmentContentStyleFont:
            // 样式一：font
            config.fontSize = 15;
            config.fontColor_nor = [UIColor darkTextColor];
            config.fontColor_sel = [UIColor redColor];
            break;
            
        case SFSegmentContentStyleImage:
            // 样式二：image
            config.image_nor = @"_nor";
            config.image_sel = @"_sel";
            break;
            
        default:
            break;
    }
    
    // 指示器样式
    switch (config.indicatorStyle) {
        case SFSegmentIndicatorStyleLine:
            // 样式一：line
            config.lineColor = [UIColor redColor];
            config.lineSize = CGSizeMake(30, 2);
            break;
            
        case SFSegmentIndicatorStyleBgColor:
            // 样式二：bgColor
            config.fontColor_sel = [UIColor whiteColor];
            config.itemBgColor_nor = [UIColor clearColor];
            config.itemBgColor_sel = [UIColor redColor];
            break;
            
        case SFSegmentIndicatorStyleArrow:
            // 样式三：arrow
            config.arrowColor = [UIColor redColor];
            config.arrowSize = CGSizeMake(8, 8*tan(M_PI/3));
            break;
            
        case SFSegmentIndicatorStyleDot:
            // 样式四：dot
            config.dotColor = [UIColor redColor];
            config.dotSize = CGSizeMake(6, 6);
            break;
            
        default:
            break;
    }
    return config;
}

@end
