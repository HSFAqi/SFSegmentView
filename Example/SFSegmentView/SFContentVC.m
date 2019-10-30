//
//  SFContentVC.m
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/19.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFContentVC.h"

#import <SFSegmentView/SFSegmentView.h>
// cell
#import "SFSegmentCell.h"
#import "SFTextFieldCell.h"
//model
#import "SFModel.h"

@interface SFContentVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;
// 数据源
@property (nonatomic,strong) SFModel *model_contentStyle;
@property (nonatomic,strong) SFModel *model_contentAlignment;
@property (nonatomic,strong) SFModel *model_contentWidthStyle;

@end

@implementation SFContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 数据源
    [self configDataSource];
    // tableView
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFSegmentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SFSegmentCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFTextFieldCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SFTextFieldCell class])];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}
// 数据源
- (void)configDataSource{
    self.model_contentStyle = [SFModel modelWithTitle:@"内容样式" subtitle:@"（contentStyle）" value:@[@"font", @"image", @"icon"] cellClassName:NSStringFromClass([SFSegmentCell class])];
    self.model_contentAlignment = [SFModel modelWithTitle:@"内容对齐方式" subtitle:@"（contentAlignment）" value:@[@"left", @"right"] cellClassName:NSStringFromClass([SFSegmentCell class])];
    self.model_contentWidthStyle = [SFModel modelWithTitle:@"内容宽度样式" subtitle:@"（contentWidthStyle）" value:@[@"equal", @"equalMax", @"auto"] cellClassName:NSStringFromClass([SFSegmentCell class])];
    self.dataSource = @[self.model_contentStyle, self.model_contentAlignment, self.model_contentWidthStyle];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SFModel *model = self.dataSource[indexPath.row];
    SFSegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SFSegmentCell class]) forIndexPath:indexPath];
    cell.model = model;
    typeof(self) weakSelf = self;
    cell.didChangedSegIndex = ^(NSInteger index) {
        model.selectedIndex = index;
        if ([model isEqual:weakSelf.model_contentStyle]) {
            switch (index) {
                case 0:
                {
                    weakSelf.config.contentStyle = SFSegmentContentStyleFont;
                }
                    break;
                    
                case 1:
                {
                    weakSelf.config.contentStyle = SFSegmentContentStyleImage;
                }
                    break;
                    
                case 2:
                {
                    weakSelf.config.contentStyle = SFSegmentContentStyleIcon;
                }
                    break;
                    
                default:
                    break;
            }
        }
        else if ([model isEqual:weakSelf.model_contentAlignment]) {
            switch (index) {
                case 0:
                {
                    weakSelf.config.contentAlignment = SFSegmentContentAlignmentLeft;
                }
                    break;
                    
                case 1:
                {
                    weakSelf.config.contentAlignment = SFSegmentContentAlignmentRight;
                }
                    break;
                    
                default:
                    break;
            }
        }
        else if ([model isEqual:weakSelf.model_contentWidthStyle]) {
            switch (index) {
                case 0:
                {
                    weakSelf.config.contentWidthStyle = SFSegmentContentWidthStyleEqual;
                }
                    break;
                    
                case 1:
                {
                    weakSelf.config.contentWidthStyle = SFSegmentContentWidthStyleEqualMax;
                }
                    break;
                    
                case 2:
                {
                    weakSelf.config.contentWidthStyle = SFSegmentContentWidthStyleAuto;
                }
                    break;
                    
                default:
                    break;
            }
        }
        if (weakSelf.changedBlock) {
            weakSelf.changedBlock(weakSelf.config);
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
