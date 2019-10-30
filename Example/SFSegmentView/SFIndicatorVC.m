//
//  SFIndicatorVC.m
//  SFSegmentView_Example
//
//  Created by 黄山锋 on 2019/10/19.
//  Copyright © 2019 hsfiOSGitHub. All rights reserved.
//

#import "SFIndicatorVC.h"

#import <SFSegmentView/SFSegmentView.h>
// cell
#import "SFSegmentCell.h"
#import "SFTextFieldCell.h"
#import "SFColorCell.h"
#import "SFTextCell.h"
//model
#import "SFModel.h"

@interface SFIndicatorVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;

// 数据源
@property (nonatomic,strong) SFModel *model_indicatorStyle;
@property (nonatomic,strong) SFModel *model_lineColor;
@property (nonatomic,strong) SFModel *model_lineSize;
@property (nonatomic,strong) SFModel *model_squareColor;
@property (nonatomic,strong) SFModel *model_squareEdgeInsert;
@property (nonatomic,strong) SFModel *model_squareCornerRadius;
@property (nonatomic,strong) SFModel *model_arrowColor;
@property (nonatomic,strong) SFModel *model_arrowSize;
@property (nonatomic,strong) SFModel *model_dotColor;
@property (nonatomic,strong) SFModel *model_dotSize;
@property (nonatomic,strong) SFModel *model_indicatorDir;
@property (nonatomic,strong) SFModel *model_isAnimation;

@end

@implementation SFIndicatorVC

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
    self.model_indicatorStyle = [SFModel modelWithTitle:@"指示器样式" subtitle:@"（indicatorStyle）" value:@[@"none", @"line", @"square", @"arrow", @"dot"] cellClassName:NSStringFromClass([SFSegmentCell class])];
    self.model_indicatorStyle.selectedIndex = 0;
    
    // line
    self.model_lineColor = [SFModel modelWithTitle:@"lineColor" subtitle:@"" value:self.config.lineColor cellClassName:NSStringFromClass([SFColorCell class])];
    self.model_lineSize = [SFModel modelWithTitle:@"lineSize" subtitle:@"" value:NSStringFromCGSize(self.config.lineSize) cellClassName:NSStringFromClass([SFTextCell class])];
    // square
    self.model_squareColor = [SFModel modelWithTitle:@"squareColor" subtitle:@"" value:self.config.squareColor cellClassName:NSStringFromClass([SFColorCell class])];
    self.model_squareEdgeInsert = [SFModel modelWithTitle:@"squareEdgeInsert" subtitle:@"" value:NSStringFromUIEdgeInsets(self.config.squareEdgeInsert) cellClassName:NSStringFromClass([SFTextCell class])];
    self.model_squareCornerRadius = [SFModel modelWithTitle:@"squareCornerRadius" subtitle:@"" value:[NSString stringWithFormat:@"%f",self.config.squareCornerRadius] cellClassName:NSStringFromClass([SFTextCell class])];
    // arrow
    self.model_arrowColor = [SFModel modelWithTitle:@"arrowColor" subtitle:@"" value:self.config.arrowColor cellClassName:NSStringFromClass([SFColorCell class])];
    self.model_arrowSize = [SFModel modelWithTitle:@"arrowSize" subtitle:@"" value:NSStringFromCGSize(self.config.arrowSize) cellClassName:NSStringFromClass([SFTextCell class])];
    // dot
    self.model_dotColor = [SFModel modelWithTitle:@"dotColor" subtitle:@"" value:self.config.dotColor cellClassName:NSStringFromClass([SFColorCell class])];
    self.model_dotSize = [SFModel modelWithTitle:@"dotSize" subtitle:@"" value:NSStringFromCGSize(self.config.dotSize) cellClassName:NSStringFromClass([SFTextCell class])];
    
    self.model_indicatorDir = [SFModel modelWithTitle:@"指示器方向" subtitle:@"（indicatorDir）" value:@[@"bottom", @"top"] cellClassName:NSStringFromClass([SFSegmentCell class])];
    
    self.model_isAnimation = [SFModel modelWithTitle:@"指示器动画" subtitle:@"（isAnimated）" value:@[@"NO", @"YES"] cellClassName:NSStringFromClass([SFSegmentCell class])];
    
    self.dataSource = @[self.model_indicatorStyle, self.model_indicatorDir];
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
            if ([model isEqual:weakSelf.model_indicatorStyle]) {
                switch (index) {
                    case 0:
                    {
                        weakSelf.dataSource = @[weakSelf.model_indicatorStyle, weakSelf.model_indicatorDir];
                        weakSelf.config.indicatorStyle = SFSegmentIndicatorStyleNone;
                    }
                        break;
                        
                    case 1:
                        {
                            weakSelf.dataSource = @[weakSelf.model_indicatorStyle, weakSelf.model_lineColor, weakSelf.model_lineSize, weakSelf.model_indicatorDir];
                            weakSelf.config.indicatorStyle = SFSegmentIndicatorStyleLine;
                        }
                            break;
                        
                    case 2:
                        {
                            weakSelf.dataSource = @[weakSelf.model_indicatorStyle, weakSelf.model_squareColor, weakSelf.model_squareEdgeInsert, weakSelf.model_squareCornerRadius, weakSelf.model_indicatorDir];
                            weakSelf.config.indicatorStyle = SFSegmentIndicatorStyleSquare;
                        }
                            break;
                        
                    case 3:
                        {
                            weakSelf.dataSource = @[weakSelf.model_indicatorStyle, weakSelf.model_arrowColor, weakSelf.model_arrowSize, weakSelf.model_indicatorDir];
                            weakSelf.config.indicatorStyle = SFSegmentIndicatorStyleArrow;
                        }
                            break;
                        
                    case 4:
                        {
                            weakSelf.dataSource = @[weakSelf.model_indicatorStyle, weakSelf.model_dotColor, weakSelf.model_dotSize, weakSelf.model_indicatorDir];
                            weakSelf.config.indicatorStyle = SFSegmentIndicatorStyleDot;
                        }
                            break;
                        
                    default:
                        break;
                }
            }
            else if ([model isEqual:weakSelf.model_indicatorDir]) {
                switch (index) {
                    case 0:
                    {
                        weakSelf.config.indicatorDir = SFSegmentIndicatorDirBottom;
                    }
                        break;
                        
                    case 1:
                    {
                        weakSelf.config.indicatorDir = SFSegmentIndicatorDirTop;
                    }
                        break;                    
                        
                    default:
                        break;
                }
            }
            else if ([model isEqual:weakSelf.model_isAnimation]) {
                switch (index) {
                    case 0:
                    {
                        weakSelf.config.isAnimated = NO;
                    }
                        break;
                        
                    case 1:
                    {
                        weakSelf.config.isAnimated = YES;
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
