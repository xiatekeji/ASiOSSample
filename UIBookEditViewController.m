//
//  UIBookEditViewController.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "UIBookEditViewController.h"
#import "ASModalCenterControll.h"
@interface UIBookEditViewController ()<ASModalCenterControllProtocol>

@end

@implementation UIBookEditViewController{
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
