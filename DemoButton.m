//
//  DemoButton.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "DemoButton.h"
typedef void(^buttonAction)();
@implementation DemoButton{
    buttonAction btnAction;
}

- (instancetype )initButtonWithDemo:(NSString *)title
                             action:(void(^)())action{
    self = [super init];
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, [UIScreen mainScreen].bounds.size.height/2-50, 100, 100);
    self.backgroundColor = [UIColor orangeColor];
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self addTarget:self action:@selector(method) forControlEvents:UIControlEventTouchUpInside];
    btnAction = action;
    return self;
}
- (void)method{
    btnAction();
}

@end
