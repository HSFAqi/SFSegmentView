//
//  SFModel.m
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/20.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFModel.h"

@implementation SFModel

+ (instancetype)modelWithTitle:(NSString *)title subtitle:(NSString *)subtitle value:(id)value cellClassName:(NSString *)cellClassName{
    SFModel *model = [[SFModel alloc]init];
    model.title = title;
    model.subtitle = subtitle;
    model.value = value;
    model.cellClassName = cellClassName;
    return model;
}

@end
