//
//  YJFirstViewController.m
//  YJUITableViewFactory
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJFirstViewController.h"
#import "YJTestTableViewCell.h"

@interface YJFirstViewController () <YJUITableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJUITableViewDataSource *dataSourcePlain;

@end

@implementation YJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataSourcePlain = [[YJUITableViewDataSource alloc] initWithTableView:self.tableView];
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
    [self test5];
}

#pragma mark - 测试数据
- (void)initTestData {
    // 测试数据
    for (int i=0; i<10; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJUITableCellObject *cellObject = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
    [self.tableView reloadData];
}

#pragma mark - 使用默认的YJUITableCellObject
- (void)test1 {
    [self initTestData];
}

#pragma mark - 使用自定义的YJUITableViewCellObject
- (void)test2 {
    // 测试数据
    for (int i=0; i<20; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJTestTableCellObject *cellObject = [[YJTestTableCellObject alloc] init];
        cellObject.cellModel = cellModel;
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
}

#pragma mark - 通过协议监听点击dell
- (void)test3 {
    self.dataSourcePlain.tableViewDelegate.cellDelegate = self;
    [self initTestData];
}

#pragma mark YJUITableViewDelegateProtocol
- (void)tableViewDidSelectCellWithCellObject:(YJUITableCellObject *)cellObject tableViewCell:(UITableViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)tableViewLoadingPageData:(YJUITableCellObject *)cellObject willDisplayCell:(UITableViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self initTestData];
}

- (void)tableView:(UITableView *)tableView scroll:(YJUITableViewScroll)scroll {
    NSLog(@"%lu", scroll);
}

#pragma mark - 通过block监听点击dell
- (void)test4 {
    self.dataSourcePlain.tableViewDelegate.cellBlock = ^(YJUITableCellObject *cellObject, UITableViewCell *tableViewCell) {
        NSLog(@"%@", cellObject.indexPath);
    };
    [self initTestData];
}

#pragma mark - 悬浮测试
- (void)test5 {
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    tableHeaderView.backgroundColor = [UIColor blueColor];
    self.tableView.tableHeaderView = tableHeaderView;
    self.dataSourcePlain.tableViewDelegate.cacheHeightStrategy = YJUITableViewCacheHeightIndexPath;
    // 测试数据
    for (int i=0; i<150; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJUITableCellObject *cellObject = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
        cellObject.suspension = i%10 == 0;
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
//    [self.dataSourcePlain.tableViewDelegate.suspensionCellView reloadData]; // 悬浮cell开始工作 IOS10+不支持
}

@end