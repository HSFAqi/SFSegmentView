//
//  SFSegmentConfig.m
//  PodTestDemo
//
//  Created by 黄山锋 on 2019/10/12.
//  Copyright © 2019 黄山锋. All rights reserved.
//

#import "SFSegmentConfig.h"

@implementation SFSegmentConfig

//默认样式
+ (instancetype)defaultConfig{
    SFSegmentConfig *config = [[SFSegmentConfig alloc]init];
    
    config.contentStyle = SFSegmentContentStyleFont;
    config.contentAlignment = SFSegmentContentAlignmentLeft;
    config.contentWidthStyle = SFSegmentContentWidthStyleEqual;
    config.maxShowNum = 4;
    config.indicatorStyle = SFSegmentIndicatorStyleNone;
    config.indicatorDir = SFSegmentIndicatorDirBottom;
    config.defaultIndex = 0;
    config.isAnimated = NO;
    config.scale = 1.0;
    
    
    
    /* ----------------分割线（默认值）---------------- */
    config.isHaveSeparator = NO;
    config.separatorColor = [UIColor colorWithRed:197/255.f green:197/255.f blue:201/255.f alpha:1];
    config.separatorHeight = 30;
    
    
    
    /* ----------------内容样式（默认值）---------------- */
    // 样式一：font
    config.fontSize = 15;
    config.fontColor_nor = [UIColor darkTextColor];
    config.fontColor_sel = [UIColor redColor];
    
    // 样式二：image
    config.image_nor = @"_nor";
    config.image_sel = @"_sel";
    
    // 样式三：icon
    config.iconTintColor_nor = [UIColor lightGrayColor];
    config.iconTintColor_sel = [UIColor blueColor];
    
    
    
    /* ----------------指示器样式（默认值）---------------- */
    // 样式一：none
    
    // 样式二：line
    config.lineColor = [UIColor redColor];
    config.lineSize = CGSizeMake(30, 2);
    
    // 样式三：square
    config.squareColor = [UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1];
    config.squareEdgeInsert = UIEdgeInsetsMake(5, 10, 5, 10);
    config.squareCornerRadius = 4;
    
    // 样式四：arrow
    config.arrowColor = [UIColor redColor];
    config.arrowSize = CGSizeMake(8, 4*tan(M_PI/3));
    
    // 样式五：dot
    config.dotColor = [UIColor redColor];
    config.dotSize = CGSizeMake(6, 6);
    
    
    
    
    
    return config;
}





@end
