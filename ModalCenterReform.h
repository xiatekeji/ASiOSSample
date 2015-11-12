//
//  ModalCenterReform.h
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ASModalCenterControll.h"
@interface ModalCenterReform : NSObject
@property (strong, nonatomic) NSDictionary *modalParamter;
@property (strong, nonatomic) UIViewController <ASModalCenterControllProtocol>*controller;

- (instancetype)initWithIdentifer:(NSString *)identifer
                    andParameters:(NSDictionary *)parameter;


@end
