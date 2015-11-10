//
//  ModalCenterReform.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ModalCenterReform.h"

@implementation ModalCenterReform
- (instancetype)initWithIdentiier:(NSString *)identifier andParameters:(NSDictionary *)parameter{
    NSString *classStr ;
    if ([identifier isEqualToString:@"book"]) {
        classStr = @"BookViewController";
    }else if([identifier isEqualToString:@"bookEdit"]){
        classStr = @"UIBookEditViewController";
    }else if([identifier isEqualToString:@"size"]){
        classStr = @"UISizeViewController";
    }else if([identifier isEqualToString:@"frameEdit"]){
        classStr = @"UIFrameEditViewController";
    }else if([identifier isEqualToString:@"web"]){
        classStr = @"CSWebViewController";
    }
    
    Class controller = NSClassFromString(classStr);
    

    UIViewController <ASModalCenterControllProtocol>*vc = [[controller alloc]init];
   
    if (vc) {
        _controller = vc;
    }
 
    
    if (parameter) {
        _modalParameters = parameter;
    }
    
    
    return self;
}

@end
