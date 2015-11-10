//
//  ASModalCenterControll.h
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class ASModalCenterControll;
@protocol ASModalCenterControllProtocol <NSObject>

@required
/**
 * @brief 压入视图控制器带参协议
 */
- (void)pushControllerWithParameters:(NSDictionary *)parameters;
@optional

/**
 * @brief 返回视图控制器带参协议
 */
- (void)popControllerWithParameters:(NSDictionary *)parameters;

@end

@interface ASModalCenterControll : NSObject 
/**
 * @brief 初始化对象
 */
+ (instancetype)shareModalCenter;

/**
 * @brief 获取当前视图控制器
 */
- (UIViewController *)currentViewController;
/**
 * @brief 获取当前模块试图控制器
 */
- (__kindof UIViewController *)currentModalViewController;
/**
 * @brief 使用前必须先设置根视图控制器
 */
- (void)setRootViewController:(UIViewController *)rootViewController;

- (void)popToViewController:(UIViewController *)controller isAnimation:(BOOL)animation;

- (void)popFormerlyViewControllerWithAnimation:(BOOL)animation;

- (void)popHomeViewControllerWithAnimation:(BOOL)animation;

- (void)pushViewController:(UIViewController <ASModalCenterControllProtocol>*)controller
                parameters:(NSDictionary *)parameter
               isAnimation:(BOOL)animation;

- (void)presentViewController:(UIViewController <ASModalCenterControllProtocol>*)controller
                   parameters:(NSDictionary *)parameter
                  isAnimation:(BOOL)animation
                   completion:(void(^)())finish;
/**
 * @brief 替换当前控制器
 */
- (void)changeCurrentViewController:(UIViewController *)controller isAnimation:(BOOL)animation;

- (void)dismissCurrentModalViewControlleAnimation:(BOOL)animation
                              completion:(void(^)())finish;
@end
