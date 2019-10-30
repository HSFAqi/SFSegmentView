//
//  SFOtherVC.m
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/19.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFOtherVC.h"

#import <SFSegmentView/SFSegmentView.h>
// cell
#import "SFSegmentCell.h"
#import "SFTextFieldCell.h"
#import "SFColorCell.h"
#import "SFTextCell.h"
//model
#import "SFModel.h"

@interface SFOtherVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) SFModel *model_maxShowNum;
@property (nonatomic,strong) SFModel *model_defaultIndex;
@property (nonatomic,strong) SFModel *model_isHaveSeparator;
@property (nonatomic,strong) SFModel *model_separatorColor;
@property (nonatomic,strong) SFModel *model_separatorHeight;
@property (nonatomic,strong) SFModel *model_scale;

@end

@implementation SFOtherVC

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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFColorCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SFColorCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SFTextCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SFTextCell class])];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

// 数据源
- (void)configDataSource{
    self.model_isHaveSeparator = [SFModel modelWithTitle:@"分割线" subtitle:@"（isHaveSeparator）" value:@[@"NO", @"YES"] cellClassName:NSStringFromClass([SFSegmentCell class])];
    self.model_maxShowNum = [SFModel modelWithTitle:@"一屏最多显示item个数" subtitle:@"（maxShowNum）" value:[NSString stringWithFormat:@"%ld",self.config.maxShowNum] cellClassName:NSStringFromClass([SFTextCell class])];
    self.model_defaultIndex = [SFModel modelWithTitle:@"默认选中" subtitle:@"（defaultIndex）" value:[NSString stringWithFormat:@"%ld",self.config.defaultIndex] cellClassName:NSStringFromClass([SFTextCell class])];
    self.model_separatorColor = [SFModel modelWithTitle:@"分割线颜色" subtitle:@"（separatorColor）" value:self.config.separatorColor cellClassName:NSStringFromClass([SFColorCell class])];
    self.model_separatorHeight = [SFModel modelWithTitle:@"分割线高度" subtitle:@"（separatorHeight）" value:[NSString stringWithFormat:@"%f",self.config.separatorHeight] cellClassName:NSStringFromClass([SFTextCell class])];
    self.model_scale = [SFModel modelWithTitle:@"缩放比例" subtitle:@"（scale）" value:[NSString stringWithFormat:@"%.2f",self.config.scale] cellClassName:NSStringFromClass([SFTextCell class])];
    
    self.dataSource = @[self.model_isHaveSeparator, self.model_maxShowNum, self.model_defaultIndex, self.model_separatorColor, self.model_separatorHeight, self.model_scale];
}
#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SFModel *model = self.dataSource[indexPath.row];
    NSString *cellClassName = model.cellClassName;
    if ([cellClassName isEqualToString:NSStringFromClass([SFSegmentCell class])]) {
        SFSegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SFSegmentCell class]) forIndexPath:indexPath];
        cell.model = model;
        typeof(self) weakSelf = self;
        cell.didChangedSegIndex = ^(NSInteger index) {
            model.selectedIndex = index;
            if ([model isEqual:weakSelf.model_isHaveSeparator]) {
                switch (index) {
                    case 0:
                    {
                        weakSelf.config.isHaveSeparator = NO;
                    }
                        break;
                        
                    case 1:
                    {
                        weakSelf.config.isHaveSeparator = YES;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            [weakSelf.tableView reloadData];
            if (weakSelf.changedBlock) {
                weakSelf.changedBlock(weakSelf.config);
            }
        };
        return cell;
    }
    else if ([cellClassName isEqualToString:NSStringFromClass([SFTextFieldCell class])]) {
        SFTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SFTextFieldCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    else if ([cellClassName isEqualToString:NSStringFromClass([SFColorCell class])]) {
        SFColorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SFColorCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    else if ([cellClassName isEqualToString:NSStringFromClass([SFTextCell class])]) {
        SFTextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SFTextCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    return nil;
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
