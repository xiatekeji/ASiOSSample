//
//  ASBookEditViewController.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import "SBTickerView.h"
#import "ASBookEditViewController.h"
#import "DemoButton.h"
#import "ASNavigator.h"
#import "ModalCenterReform.h"
@interface ASBookEditViewController ()
@property (strong, nonatomic)  SBTickerView *sheetView;
@end

@implementation ASBookEditViewController
- (void)skipPageProtocol:(NSDictionary *)parameters{
    if ([parameters objectForKey:@"title"]) {
        self.title = [parameters objectForKey:@"title"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    DemoButton *demo = [[DemoButton alloc]initButtonWithDemo:@"Restart" action:^{
        [[ASNavigator shareModalCenter] popHomeViewControllerWithAnimation:YES];
    }];
    
    DemoButton *demo1 = [[DemoButton alloc]initButtonWithDemo:@"Cart" action:^{
        ModalCenterReform *reform = [[ModalCenterReform alloc]initWithIdentifer:@"openCart" andParameters:nil];
        [[ASNavigator shareModalCenter] pushViewController:reform.controller parameters:reform.modalParamter isAnimation:YES];
    }];
    CGRect rect = demo1.frame;
    rect.origin.x += 250;
    demo1.frame = rect;
    [self.view addSubview:demo1];
    [self.view addSubview:demo];
    
    self.sheetView = [[SBTickerView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height/2-200,50 , 400, 200)];
    self.sheetView.delegate = self;
    self.sheetView.backgroundColor = [UIColor lightGrayColor];
    [self.sheetView setDuration:0.7];
    [self.sheetView setAllowedPanDirections:(SBTickerViewAllowedPanDirectionDown | SBTickerViewAllowedPanDirectionUp)];
    [self.sheetView setPanning:TRUE];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.backgroundColor = [UIColor blackColor];
    UIImageView *front = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yongshi.jpg"]];
    [front setFrame:view.bounds];
    [view addSubview:front];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 200, 200)];
    view1.backgroundColor = [UIColor blackColor];
    UIImageView *front1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.jpeg"]];
    [front1 setFrame:view1.bounds];
    [view1 addSubview:front1];
    UIView *front3 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [front3 addSubview:view];
    [front3 addSubview:view1];
    front3.clipsToBounds = YES;
    [self.sheetView  setFrontView:front3];
    [self.sheetView  setBackView:front3];
    [self.view addSubview:self.sheetView];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(50, 150, 50, 50);
    [left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    [left setTitle:@"Left" forState:UIControlStateNormal];
    [left setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(570, 150, 50, 50);
    [right addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    [right setTitle:@"Right" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:right];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBarHidden = NO;
     [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
}
- (void)left:(id)sender {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.backgroundColor = [UIColor blackColor];
    UIImageView *front = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yongshi.jpg"]];
    [front setFrame:view.bounds];
    [view addSubview:front];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 200, 200)];
    view1.backgroundColor = [UIColor blackColor];
    UIImageView *front1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.jpeg"]];
    [front1 setFrame:view1.bounds];
    [view1 addSubview:front1];
    UIView *front3 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [front3 addSubview:view];
    [front3 addSubview:view1];
    front3.clipsToBounds = YES;
    
    [self.sheetView tick:SBTickerViewTickDirectionDown animated:YES completion:^{
        [self.sheetView  setBackView:front3];
    }];
}
- (void)right:(id)sender {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.backgroundColor = [UIColor blackColor];
    UIImageView *front = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yongshi.jpg"]];
    [front setFrame:view.bounds];
    [view addSubview:front];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 200, 200)];
    view1.backgroundColor = [UIColor blackColor];
    UIImageView *front1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.jpeg"]];
    [front1 setFrame:view1.bounds];
    [view1 addSubview:front1];
    UIView *front3 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [front3 addSubview:view];
    [front3 addSubview:view1];
    front3.clipsToBounds = YES;
    
    [self.sheetView tick:SBTickerViewTickDirectionUp animated:YES completion:^{
        [self.sheetView  setFrontView:front3];
        
    }];
}


-(void)tickerViewDidStartTurnPage:(SBTickerViewTickDirection)direction{
    if (direction == SBTickerViewTickDirectionUp) {
        [self right:nil];
    }else{
        [self left:nil];
    }
}
@end
