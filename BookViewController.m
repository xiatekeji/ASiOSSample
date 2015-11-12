//
//  BookViewController.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "BookViewController.h"
#import "ModalCenterReform.h"
#import "ASNavigator.h"
@interface BookViewController ()<ASNavigatable>

@end

@implementation BookViewController
- (void)skipPageProtocola:(NSDictionary *)parameters{
    if ( [parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
    
    NSLog(@"p = %@",parameters);
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
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
