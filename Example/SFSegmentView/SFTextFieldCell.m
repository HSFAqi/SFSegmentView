//
//  SFTextFieldCell.m
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/19.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFTextFieldCell.h"
//model
#import "SFModel.h"

@interface SFTextFieldCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end

@implementation SFTextFieldCell

- (void)setModel:(SFModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subtitle;
    self.valueTextField.text = model.value;
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
