//
//  ASNavigator.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/13.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASNavigator.h"
#import "ASNavigationController.h"
@implementation ASNavigator{
    UINavigationController *_rootNaviViewController; // 根导航栏
    UIViewController *_currentViewController; // 当前视图控制器
    UIViewController *_currentModalViewController; //当前模块视图控制器
    NSMutableArray <UIViewController *>*_currentModalViewControllers; // 当前所有导航栏控制器
}
+ (instancetype)shareModalCenter{
    
    static ASNavigator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ASNavigator alloc]init];
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
- (__kindof UINavigationController *)innerWithHome:(UIViewController *)homeViewController{

    if (homeViewController && !_rootNaviViewController) {
        _rootNaviViewController = [[ASNavigationController alloc]initWithRootViewController:homeViewController];
        _currentViewController = homeViewController;
        _currentModalViewController = _rootNaviViewController;
        [_currentModalViewControllers addObject:_rootNaviViewController];
        
    }
    return _rootNaviViewController;
}
- (void)popToViewController:(UIViewController *)controller isAnimation:(BOOL)animation{
    
}

- (void)popFormerlyViewControllerWithAnimation:(BOOL)animation{
    if (_currentModalViewController) {
        if ([self isUINavigationController:_currentModalViewController]) {
            UINavigationController *navi =  (UINavigationController *) _currentModalViewController ;
            [navi popViewControllerAnimated:animation];
            _currentViewController = [navi.viewControllers lastObject];
        }else{
            NSLog(@"非导航栏控制器");
        }
        
    }
}

- (void)popHomeViewControllerWithAnimation:(BOOL)animation{
    if ( [self isUINavigationController:_currentModalViewController]) {
        [_rootNaviViewController popToRootViewControllerAnimated:animation];
        _currentViewController = _rootNaviViewController.topViewController;
        
        
    }
}

- (void)pushViewController:(UIViewController <ASNavigatable>*)controller
                parameters:(NSDictionary *)parameter
               isAnimation:(BOOL)animation{
    if (controller && [self isUINavigationController:_currentModalViewController] ) {
        _currentViewController = controller;
        [controller skipPageProtocol:parameter];
        [_rootNaviViewController pushViewController:controller animated:animation];
    }
}
- (void)presentViewController:(UIViewController <ASNavigatable>*)controller
                   parameters:(NSDictionary *)parameter
                  isAnimation:(BOOL)animation
                   completion:(void(^)())finish{
    if (_currentViewController) {
        [controller skipPageProtocol:parameter];
        [_currentViewController presentViewController:controller animated:animation completion:^{
            if (finish) {
                finish();
            }
            if ([self isUINavigationController:controller]) {
                UINavigationController *navi =  (UINavigationController *) controller ;
                _currentViewController =  [navi topViewController];
                _rootNaviViewController = navi;
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
 
            [_currentModalViewControllers removeLastObject];
            _currentModalViewController = [_currentModalViewControllers lastObject];
            if ([self isUINavigationController:_currentModalViewController]) {
                UINavigationController *navi =  (UINavigationController *) _currentModalViewController ;
                _currentViewController = [navi.viewControllers lastObject];
                _rootNaviViewController = navi;
            }else{
                _currentViewController = _currentModalViewController;
            }
            if (finish) {
                finish();
            }
        }];
        
    }
    
}
- (__kindof UIViewController *)fetchVCWithMemoryPath:(NSString *)memory{
    for (UIViewController *controll in _currentModalViewControllers) {
        if ([self isUINavigationController:controll ]) {
            UINavigationController *navi =  (UINavigationController *) controll ;
            for ( UIViewController *vc in navi.viewControllers ) {
                if ([[NSString stringWithFormat:@"%p",vc] isEqualToString:memory]) {
                    return vc;
                }
            }
        }
    }

  
    return nil;
}

- (BOOL)isUINavigationController:(UIViewController *)controller{
    
    if ([controller isKindOfClass:[UINavigationController class]]){
        return  YES;
    }else {
        return  NO;
    }
}

@end
