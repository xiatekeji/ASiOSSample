//
//  DemoButton.h
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/18.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoButton : UIButton
- (instancetype )initButtonWithDemo:(NSString *)title
                      action:(void(^)())action;
@end
