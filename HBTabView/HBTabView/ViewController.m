//
//  ViewController.m
//  HBTabView
//
//  Created by DylanHu on 2016/6/11.
//  Copyright © 2016年 DylanHu. All rights reserved.
//

#import "ViewController.h"
#import "HBHorizontalViewController.h"
#import "HBVerticalViewController.h"

#define keypath2(obj, path) \
(((void)(NO && ((void)obj,path,NO)), #path))

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray <NSString *> *dataArray;

@end

@implementation ViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"水平布局",@"垂直布局"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_test"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_test"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor orangeColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HBHorizontalViewController *horizontalVC = [[HBHorizontalViewController alloc] init];
        [self.navigationController pushViewController:horizontalVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        HBVerticalViewController *verticalVC = [[HBVerticalViewController alloc] init];
        [self.navigationController pushViewController:verticalVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
