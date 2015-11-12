//
//  ModalCenterReform.m
//  UIDemo
//
//  Created by XiaoSong on 15/11/5.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ModalCenterReform.h"
#define URL_PLIST_FILENAME @"Business"
static NSMutableDictionary *identiferDic;
@implementation ModalCenterReform

-(instancetype)initWithIdentifer:(NSString *)identifer andParameters:(NSDictionary *)parameter
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:URL_PLIST_FILENAME ofType:@"plist"];
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *classStr;
    

    if ([dic objectForKey:identifer]) {
        NSDictionary *refromDic = [dic objectForKey:identifer];
        if ([refromDic objectForKey:@"url"]) {
            classStr = @"HTML5ViewController";
            
        }else{
            classStr = [refromDic objectForKey:@"class"];
        }
        _modalParamter = refromDic;
    }
    Class controller = NSClassFromString(classStr);
    
    UIViewController <ASNavigatable>*VC = [[controller  alloc] init];
    if (VC) {
        _controller = VC;
    }
    if (parameter) {
        _modalParamter = parameter;
    }
//    if (identiferDic) {
//        if ( [identiferDic objectForKey:identifer]) {
//            if ( [[ASNavigator shareModalCenter] fetchVCWithMemoryPath:[identiferDic objectForKey:identifer]]) {
//               _controller = [[ASNavigator shareModalCenter] fetchVCWithMemoryPath:[identiferDic objectForKey:identifer]];
//            }else{
//                
//                 [identiferDic setValue:[NSString stringWithFormat:@"%p",VC] forKey:identifer];
//             
//            }
//           
//        }
//    }else{
//        identiferDic = [[NSMutableDictionary alloc]init];
//        [identiferDic setValue:[NSString stringWithFormat:@"%p",VC] forKey:identifer];
//        
//    }
 
    

    
    return self;
}

@end
