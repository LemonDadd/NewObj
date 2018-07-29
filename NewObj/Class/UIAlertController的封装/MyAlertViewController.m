//
//  MyAlertViewController.m
//  NewObj
//
//  Created by 关云秀 on 2018/7/26.
//  Copyright © 2018年 xuannalisha. All rights reserved.
//

#import "MyAlertViewController.h"
#import "FXShowAlertController.h"

@interface MyAlertViewController ()

@end

@implementation MyAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"使用一",
                     @"使用二",
                     @"使用三",
                     @"使用四"];
    
    NSMutableArray *btnArray = [NSMutableArray array];
    for (int i=0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.view addSubview:btn];
        [btnArray addObject:btn];
    }
    
    [btnArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:50 leadSpacing:100 tailSpacing:100];
    [btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.4);
    }];
}

- (void)btnClick:(UIButton *)sender {
    if (sender.tag == 0) {
        [[FXShowAlertController shareInstance] showAlert:@"使用一" message:@"这个是使用一" cancelTitle:@"取消" titleArray:@[@"确定"] viewController:self confirm:^(NSInteger buttonTag) {
            NSLog(@"点了确定");
        }];
    }
    
    if (sender.tag == 1) {
        [[FXShowAlertController shareInstance] showAlert:@"使用二" message:@"这个是使用二" cancelTitle:@"取消" viewController:self confirm:^(NSInteger buttonTag) {
            NSLog(@"点了确定%ld",(long)buttonTag);
        } buttonTitles:@"确定0",@"确定1", nil];
    }
    
    if (sender.tag == 2) {
        [[FXShowAlertController shareInstance]showSheet:@"使用三" message:@"这个是使用三" cancelTitle:@"取消" titleArray:@[@"确定"] viewController:self confirm:^(NSInteger buttonTag) {
             NSLog(@"点了确定");
        }];
    }
    
    if (sender.tag == 3) {
        [[FXShowAlertController shareInstance]showSheet:@"使用四" message:@"这个是使用四" cancelTitle:@"取消" viewController:self confirm:^(NSInteger buttonTag) {
             NSLog(@"点了确定%ld",(long)buttonTag);
        } buttonTitles:@"确定0",@"确定1", nil];
    }
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
