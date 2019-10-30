//
//  SFSegmentCell.m
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/19.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFSegmentCell.h"
//model
#import "SFModel.h"

@interface SFSegmentCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *valueSegView;

@end

@implementation SFSegmentCell

- (void)setModel:(SFModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subtitle;
    [self.valueSegView removeAllSegments];
    NSArray *arr = (NSArray *)model.value;
    for (int i=0; i<[arr count]; i++) {
        [self.valueSegView insertSegmentWithTitle:arr[i] atIndex:i animated:NO];
    }
    self.valueSegView.selectedSegmentIndex = model.selectedIndex;
}
- (IBAction)segViewAction:(UISegmentedControl *)sender {
    if (self.didChangedSegIndex) {
        self.didChangedSegIndex(sender.selectedSegmentIndex);
    }
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
