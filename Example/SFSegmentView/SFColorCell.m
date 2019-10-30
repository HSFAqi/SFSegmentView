//
//  SFColorCell.m
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/20.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFColorCell.h"
//model
#import "SFModel.h"

@interface SFColorCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;

@end

@implementation SFColorCell

- (void)setModel:(SFModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.colorBtn.backgroundColor = model.value;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
