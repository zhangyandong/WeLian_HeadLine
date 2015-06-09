//
//  BasicViewController.m
//  Welian
//
//  Created by dong on 15/1/4.
//  Copyright (c) 2015年 chuansongmen. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController () <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation BasicViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置左侧按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    // 是否可右滑返回
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // 清除内存中的图片缓存
//    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
//    [mgr cancelAll];
//    [mgr.imageCache clearMemory];
    DLog(@"%@ ------  didReceiveMemoryWarning",[self class]);
}

- (void)dealloc
{
    DLog(@"%@ ------  dealloc",[self class]);
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
