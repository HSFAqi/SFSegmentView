//
//  SFSegmentView.m
//  PodTestDemo
//
//  Created by 黄山锋 on 2019/10/12.
//  Copyright © 2019 黄山锋. All rights reserved.
//

#import "SFSegmentView.h"

#import <Masonry/Masonry.h>
#import "SFSegmentConfig.h"
#define kSeparatorWidth 1
#define kTagAdding 100

@interface SFSegmentView ()

@property (nonatomic,strong) UIButton *item_cur;

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *square;
@property (nonatomic,strong) UIView *arrow;
@property (nonatomic,strong) UIView *dot;

@end

@implementation SFSegmentView


#pragma mark initializer
- (instancetype)initWithConfig:(nullable SFSegmentConfig *)config frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.config = config?config:[SFSegmentConfig defaultConfig];
    }
    return self;
}
+ (instancetype)segmentViewWithConfig:(nullable SFSegmentConfig *)config frame:(CGRect)frame{
    SFSegmentView *selectView = [[SFSegmentView alloc]initWithConfig:config frame:frame];
    return selectView;
}

#pragma mark setter
- (void)setContents:(NSArray *)contents{
    _contents = contents;
    // 清空
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    // 添加items
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat w = self.frame.size.width/contents.count;
    CGFloat h = self.frame.size.height;
    NSInteger defaultIndex = self.config.defaultIndex;
    if (defaultIndex < 0 || defaultIndex >= contents.count) {
        defaultIndex = 0;
    }
    for (int i=0; i < contents.count; i++) {
        x = w*i;
        CGRect rect = CGRectMake(x, y, w, h);
        NSString *content = contents[i];
        UIButton *item = [self createCustomItemWithFrame:rect content:content];
        item.selected = NO;
        [item setTag:i+kTagAdding];
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == defaultIndex) {
            item.selected = YES;
            if (self.config.contentStyle == SFSegmentContentStyleIcon) {
                item.tintColor = self.config.imageTintColor_sel;
            }
            self.item_cur = item;
            // indicator
            [self createCustomIndicatorStyleWithItem:item];
            // 默认选中的回调
            if (self.didSelectedItemBlock) {
                self.didSelectedItemBlock(item.tag-kTagAdding);
            }
        }
        if (self.config.isHaveSeparator && (i != 0)) {
            CGFloat separatorX = x-kSeparatorWidth/2;
            [self createSeparatorWithX:separatorX];
        }
    }
}
#pragma mark item
- (UIButton *)createCustomItemWithFrame:(CGRect)frame content:(NSString *)content{
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:item];
    item.backgroundColor = [UIColor clearColor];
    switch (self.config.contentStyle) {
        case SFSegmentContentStyleFont:
            [item setTitle:content forState:UIControlStateNormal];
            item.titleLabel.font = [UIFont systemFontOfSize:self.config.fontSize];
            [item setTitleColor:self.config.fontColor_nor forState:UIControlStateNormal];
            [item setTitleColor:self.config.fontColor_sel forState:UIControlStateSelected];
            break;
            
        case SFSegmentContentStyleImage:
            [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",content,self.config.image_nor]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",content,self.config.image_sel]] forState:UIControlStateSelected];
            break;
            
        case SFSegmentContentStyleIcon:
            if (@available(iOS 13.0, *)) {
                [item setImage:[[UIImage imageNamed:content] imageWithTintColor:self.config.imageTintColor_nor] forState:UIControlStateNormal];
                [item setImage:[[UIImage imageNamed:content] imageWithTintColor:self.config.imageTintColor_sel] forState:UIControlStateSelected];
            } else {
                UIImage *image = [[UIImage imageNamed:content] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                [item setImage:image forState:UIControlStateNormal];
                [item setImage:image forState:UIControlStateSelected];
            }
            break;
            
        default:
            break;
    }
    // 布局
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(frame.origin.y);
        make.left.equalTo(self).offset(frame.origin.x);
        make.size.mas_equalTo(frame.size);
    }];
    return item;
}

#pragma mark separator
- (void)createSeparatorWithX:(CGFloat)x{
    UIView *separator = [[UIView alloc]init];
    [self addSubview:separator];
    separator.backgroundColor = self.config.separatorColor;
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(x);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kSeparatorWidth, self.config.separatorHeight));
    }];
}

#pragma mark indicatorStyle
- (void)createCustomIndicatorStyleWithItem:(UIButton *)item{
    switch (self.config.indicatorStyle) {
        case SFSegmentIndicatorStyleNone:
            [self noneStyleWithItem:item];
            break;
            
        case SFSegmentIndicatorStyleLine:
            [self lineStyleWithItem:item];
            break;
        
        case SFSegmentIndicatorStyleSquare:
            [self squareStyleWithItem:item];
            break;
        
        case SFSegmentIndicatorStyleArrow:
            [self arrowStyleWithItem:item];
            break;
            
        case SFSegmentIndicatorStyleDot:
            [self dotStyleWithItem:item];
            break;
        default:
            break;
    }
}
// 样式一：none
- (void)noneStyleWithItem:(UIButton *)item{
    
}
// 样式二：line
- (void)lineStyleWithItem:(UIButton *)item{
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = self.config.lineColor;
    [self addSubview:self.line];
    __weak UIButton *item_weak = item;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (self.config.indicatorDir) {
            case SFSegmentIndicatorDirBottom:
                make.bottom.equalTo(self);
                break;
            case SFSegmentIndicatorDirTop:
                make.top.equalTo(self);
                break;
            default:
                break;
        }
        make.centerX.equalTo(item_weak);
        make.size.mas_equalTo(self.config.lineSize);
    }];
}
// 样式三：square
- (void)squareStyleWithItem:(UIButton *)item{
    self.square = [[UIView alloc]init];
    self.square.backgroundColor = self.config.squareColor;
    [self addSubview:self.square];
    [self sendSubviewToBack:self.square];
    if (self.config.squareCornerRadius > 0) {
        self.square.layer.masksToBounds = YES;
        self.square.layer.cornerRadius = self.config.squareCornerRadius;
    }
    __weak UIButton *item_weak = item;
    [self.square mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item_weak).offset(self.config.squareEdgeInsert.top);
        make.left.equalTo(item_weak).offset(self.config.squareEdgeInsert.left);
        make.bottom.equalTo(item_weak).offset(-self.config.squareEdgeInsert.bottom);
        make.right.equalTo(item_weak).offset(-self.config.squareEdgeInsert.right);
    }];
}
// 样式四：arrow
- (void)arrowStyleWithItem:(UIButton *)item{
    self.arrow = [[UIView alloc]init];
    self.arrow.backgroundColor = self.config.arrowColor;
    [self addSubview:self.arrow];
    [self drawArrow];
    __weak UIButton *item_weak = item;
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (self.config.indicatorDir) {
            case SFSegmentIndicatorDirBottom:
                make.bottom.equalTo(self);
                break;
            case SFSegmentIndicatorDirTop:
                make.top.equalTo(self);
                break;
            default:
                break;
        }
        make.centerX.equalTo(item_weak);
        make.size.mas_equalTo(self.config.arrowSize);
    }];
}
// 画三角
- (void)drawArrow{
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    switch (self.config.indicatorDir) {
        case SFSegmentIndicatorDirBottom:
            // 正三角
            point1 = CGPointMake(0, self.config.arrowSize.height);
            point2 = CGPointMake(self.config.arrowSize.width/2, 0);
            point3 = CGPointMake(self.config.arrowSize.width, self.config.arrowSize.height);
            break;
        
        case SFSegmentIndicatorDirTop:
            // 倒三角
            point1 = CGPointMake(0, 0);
            point2 = CGPointMake(self.config.arrowSize.width/2, self.config.arrowSize.height);
            point3 = CGPointMake(self.config.arrowSize.width, 0);
            break;
        
        default:
            break;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path closePath];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.lineWidth = 1;
    maskLayer.strokeColor = self.config.arrowColor.CGColor;
    maskLayer.path = path.CGPath;
    self.arrow.layer.mask = maskLayer;
}
// 样式五：dot
- (void)dotStyleWithItem:(UIButton *)item{
    self.dot = [[UIView alloc]init];
    self.dot.backgroundColor = self.config.dotColor;
    [self addSubview:self.dot];
    [self drawDot];
    __weak UIButton *item_weak = item;
    [self.dot mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (self.config.indicatorDir) {
            case SFSegmentIndicatorDirBottom:
                make.bottom.equalTo(self);
                break;
            case SFSegmentIndicatorDirTop:
                make.top.equalTo(self);
                break;
            default:
                break;
        }
        make.centerX.equalTo(item_weak);
        make.size.mas_equalTo(self.config.dotSize);
    }];
}
// 画圆
- (void)drawDot{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.config.dotSize.width, self.config.dotSize.height) cornerRadius:self.config.dotSize.width/2];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.lineWidth = 1;
    maskLayer.strokeColor = self.config.dotColor.CGColor;
    maskLayer.path = path.CGPath;
    self.dot.layer.mask = maskLayer;
}

#pragma mark Actions
- (void)itemAction:(UIButton *)sender{
    if (self.config.isAnimated) {
        typeof(self) weakSelf = self;
        __weak UIButton *weakItem = sender;
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf movingActionWithItem:weakItem];
        }completion:^(BOOL finished) {
            [weakSelf movedActionWithItem:weakItem];
        }];
    }else{
        [self movingActionWithItem:sender];
        [self movedActionWithItem:sender];
    }
    // 回调
    if (self.didSelectedItemBlock) {
        self.didSelectedItemBlock(sender.tag-kTagAdding);
    }
}
// 移动过程中
- (void)movingActionWithItem:(UIButton *)sender{
    UIView *indicator;
    switch (self.config.indicatorStyle) {
        case SFSegmentIndicatorStyleLine:
            indicator = self.line;
            break;
        
        case SFSegmentIndicatorStyleSquare:
            indicator = self.square;
            break;
        
        case SFSegmentIndicatorStyleArrow:
            indicator = self.arrow;
            break;
            
        case SFSegmentIndicatorStyleDot:
            indicator = self.dot;
            break;
        default:
            break;
    }
    if (indicator) {
        CGFloat centerY = indicator.center.y;
        indicator.center = CGPointMake(sender.center.x, centerY);
    }
}
// 移动结束时
- (void)movedActionWithItem:(UIButton *)sender{
    self.item_cur.selected = NO;
    if (self.config.contentStyle == SFSegmentContentStyleIcon) {
        self.item_cur.tintColor = self.config.imageTintColor_nor;
    }
    sender.selected = YES;
    if (self.config.contentStyle == SFSegmentContentStyleIcon) {
        sender.tintColor = self.config.imageTintColor_sel;
    }
    self.item_cur = sender;
}

#pragma mark move action
// 向前移动
- (void)moveForward{
    NSInteger curIndx = self.item_cur.tag;
    if (curIndx == self.contents.count-1+kTagAdding) {
        return;
    }
    UIButton *item = [self viewWithTag:(curIndx+1)];
    [self itemAction:item];
}
// 向后移动
- (void)moveBackward{
    NSInteger curIndx = self.item_cur.tag;
    if (curIndx == kTagAdding) {
        return;
    }
    UIButton *item = [self viewWithTag:(curIndx-1)];
    [self itemAction:item];
}
// 移动到指定位置
- (void)moveTo:(NSInteger)index{
    if (index >= 0 && index <= self.contents.count-1) {
        NSInteger userfulIndex = index + kTagAdding;
        UIButton *item = [self viewWithTag:userfulIndex];
        [self itemAction:item];
    }
}




#pragma mark lazy load
- (SFSegmentConfig *)config{
    if (!_config) {
        _config = [SFSegmentConfig defaultConfig];
    }
    return _config;
}




@end
