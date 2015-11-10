//
//  ASModalCenterControll.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASModalCenterControll.h"
#import "ASModalCenterBaseController.h"
@implementation ASModalCenterControll{

    ASModalCenterBaseController *_rootNaviViewController; // 根导航栏
    UIViewController *_currentViewController; // 当前视图控制器
    UIViewController *_currentModalViewController; //当前模块视图控制器
    NSMutableArray <UIViewController *>*_currentModalViewControllers; // 当前所有导航栏控制器
}
+ (instancetype)shareModalCenter{
    
        static ASModalCenterControll *instance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[ASModalCenterControll alloc]init];
            instance -> _currentModalViewControllers = [[NSMutableArray alloc]init];
        });
        
        return instance;

}
- (UIViewController *)currentModalNaviViewController{
    return _currentModalViewController;
}
- (UIViewController *)currentViewController{
    return _currentViewController;
}
- (__kindof UIViewController *)currentModalViewController{
    
    return _currentModalViewController;
}
- (void)setRootViewController:(UIViewController *)rootViewController{
    if (rootViewController && !_rootNaviViewController) {
        _rootNaviViewController = [[ASModalCenterBaseController alloc]initWithRootViewController:rootViewController];
        _currentViewController = rootViewController;
        _currentModalViewController = _rootNaviViewController;
        [_currentModalViewControllers addObject:_rootNaviViewController];
    }
 
   
}
- (void)popToViewController:(UIViewController *)controller isAnimation:(BOOL)animation{
    
}

- (void)popFormerlyViewControllerWithAnimation:(BOOL)animation{
    if (_currentModalViewController) {
        if ([self isUINavigationController:_currentModalViewController]) {
            UINavigationController *navi =  (UINavigationController *) _currentModalViewController ;
            [navi popToRootViewControllerAnimated:YES];
        }else{
            NSLog(@"非导航栏控制器");
        }
     
    }
}

- (void)popHomeViewControllerWithAnimation:(BOOL)animation{
    if (_currentModalViewController == _rootNaviViewController) {
        [_rootNaviViewController popToRootViewControllerAnimated:animation];
        _currentViewController = _rootNaviViewController.topViewController;
   
       
    }
}

- (void)pushViewController:(UIViewController <ASModalCenterControllProtocol>*)controller
                parameters:(NSDictionary *)parameter
               isAnimation:(BOOL)animation{
    if (controller && [self isUINavigationController:_currentModalViewController] ) {
        _currentViewController = controller;
        [controller pushControllerWithParameters:parameter];
        [_rootNaviViewController pushViewController:controller animated:animation];
    }
}
- (void)presentViewController:(UIViewController <ASModalCenterControllProtocol>*)controller
                   parameters:(NSDictionary *)parameter
                  isAnimation:(BOOL)animation
                   completion:(void(^)())finish{
    if (_currentViewController) {
        [controller pushControllerWithParameters:parameter];
        [_currentViewController presentViewController:controller animated:animation completion:^{
            if (finish) {
                finish();
            }
            if ([self isUINavigationController:controller]) {
                UINavigationController *navi =  (UINavigationController *) controller ;
                _currentViewController =  [navi topViewController];
            }else{
                _currentViewController = controller;
            }

           
        }];
        [_currentModalViewControllers addObject:controller];
        _currentModalViewController = controller;
    
    }
    
}
- (void)changeCurrentViewController:(UIViewController *)controller isAnimation:(BOOL)animation{
    
}

- (void)dismissCurrentModalViewControlleAnimation:(BOOL)animation
                                       completion:(void(^)())finish{
    if (_currentModalViewController) {
        [_currentModalViewController dismissViewControllerAnimated:animation completion:^{
            if (finish) {
                finish();
            }
           [_currentModalViewControllers removeLastObject];
            _currentModalViewController = [_currentModalViewControllers lastObject];
            if ([self isUINavigationController:_currentModalViewController]) {
                  UINavigationController *navi =  (UINavigationController *) _currentModalViewController ;
                _currentViewController = [navi.viewControllers lastObject];
            }else{
                _currentViewController = _currentModalViewController;
            }
        }];
    
    }
  
}


- (BOOL)isUINavigationController:(UIViewController *)controller{
   
    if ([controller isKindOfClass:[UINavigationController class]]){
        return  YES;
    }else {
        return  NO;
    }
}
@end
