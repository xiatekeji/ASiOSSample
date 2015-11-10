//
//  UIFrameEditViewController.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "UIFrameEditViewController.h"
#import "ModalCenterReform.h"
@interface UIFrameEditViewController ()<ASModalCenterControllProtocol>

@end

@implementation UIFrameEditViewController{
    NSDictionary *_p;
}
- (void)pushControllerWithParameters:(NSDictionary *)parameters{
    _p = parameters;
    NSLog(@"p = %@",parameters);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [_p objectForKey:@"Modal"];
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
