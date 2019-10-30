//
//  SFSegmentCell.h
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/19.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SFModel;

NS_ASSUME_NONNULL_BEGIN

@interface SFSegmentCell : UITableViewCell

@property (nonatomic,strong) SFModel *model;
@property (nonatomic,copy) void (^didChangedSegIndex)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
