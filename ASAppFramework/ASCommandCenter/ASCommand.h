//
//  ASCommand.h
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/18.
//  Copyright © 2015年 侠特科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASCommand<NSObject>

@required

- (void)executeWithEvent: (id _Nullable)event;

@end

#pragma mark -

@interface ASCommand : NSObject<ASCommand>

@end
