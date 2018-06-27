//
//  HBVerticalViewController.m
//  HBTabView
//
//  Created by DylanHu on 2016/6/26.
//  Copyright © 2016年 DylanHu. All rights reserved.
//

#import "HBVerticalViewController.h"
#import "HBTabView.h"
#import "Test01ViewController.h"
#import "Test02ViewController.h"
#import "Test03ViewController.h"
#import "Test04ViewController.h"
#import "HBSegmentBar.h"

@interface HBVerticalViewController ()

@end

@implementation HBVerticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBarHidden = YES;
    HBTabView *tabView = [[HBTabView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) parentViewController:self showType:HBTabViewShowTypeVertical];
    [self.view addSubview:tabView];
    
    Test01ViewController *test01VC = [[Test01ViewController alloc] init];
    [tabView addItemWithTitle:@"测试1" containerViewWithViewController:test01VC];
    
    Test02ViewController *test02VC = [[Test02ViewController alloc] init];
    [tabView addItemWithTitle:@"测试2" containerViewWithViewController:test02VC];
    test02VC.titleString = @"测试2";
    
    Test03ViewController *test03VC = [[Test03ViewController alloc] init];
    [tabView addItemWithTitle:@"测试3" containerViewWithViewController:test03VC];
    test03VC.titleString = @"测试3";
    
    Test04ViewController *test04VC = [[Test04ViewController alloc] init];
    [tabView addItemWithTitle:@"测试4嘎嘎嘎" containerViewWithViewController:test04VC];
    test04VC.titleString = @"测试4";
    
    Test01ViewController *test05VC = [[Test01ViewController alloc] init];
    [tabView addItemWithTitle:@"测试5" containerViewWithViewController:test05VC];
    
    Test02ViewController *test06VC = [[Test02ViewController alloc] init];
    [tabView addItemWithTitle:@"测试6" containerViewWithViewController:test06VC];
    test06VC.titleString = @"测试6";
    
    Test03ViewController *test07VC = [[Test03ViewController alloc] init];
    [tabView addItemWithTitle:@"测试7" containerViewWithViewController:test07VC];
    test07VC.titleString = @"测试7";
    
    Test04ViewController *test08VC = [[Test04ViewController alloc] init];
    [tabView addItemWithTitle:@"测试8啊啊啊" containerViewWithViewController:test08VC];
    test08VC.titleString = @"测试8";
    
    Test01ViewController *test09VC = [[Test01ViewController alloc] init];
    [tabView addItemWithTitle:@"测试9" containerViewWithViewController:test09VC];
    
    Test02ViewController *test010VC = [[Test02ViewController alloc] init];
    [tabView addItemWithTitle:@"测试10" containerViewWithViewController:test010VC];
    test010VC.titleString = @"测试10";
    
    Test03ViewController *test011VC = [[Test03ViewController alloc] init];
    [tabView addItemWithTitle:@"测试11你好好哈哈" containerViewWithViewController:test011VC];
    test011VC.titleString = @"测试11";
    
    Test04ViewController *test012VC = [[Test04ViewController alloc] init];
    [tabView addItemWithTitle:@"测试12" containerViewWithViewController:test012VC];
    test012VC.titleString = @"测试12";
    
    Test01ViewController *test013VC = [[Test01ViewController alloc] init];
    [tabView addItemWithTitle:@"测试13呵呵" containerViewWithViewController:test013VC];
    
    Test02ViewController *test014VC = [[Test02ViewController alloc] init];
    [tabView addItemWithTitle:@"测试14" containerViewWithViewController:test014VC];
    test014VC.titleString = @"测试14";
    
    Test03ViewController *test015VC = [[Test03ViewController alloc] init];
    [tabView addItemWithTitle:@"测试15哈哈哈" containerViewWithViewController:test015VC];
    test015VC.titleString = @"测试15";
    
    Test04ViewController *test016VC = [[Test04ViewController alloc] init];
    [tabView addItemWithTitle:@"测试16" containerViewWithViewController:test016VC];
    test016VC.titleString = @"测试16";
    
    [tabView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
