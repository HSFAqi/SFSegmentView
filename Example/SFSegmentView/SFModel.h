//
//  SFModel.h
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/20.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subtitle;
@property (nonatomic,strong) id value;
@property (nonatomic,strong) NSString *cellClassName;
@property (nonatomic,assign) NSInteger selectedIndex;

+ (instancetype)modelWithTitle:(NSString *)title subtitle:(NSString *)subtitle value:(id)value cellClassName:(NSString *)cellClassName;

@end

NS_ASSUME_NONNULL_END
