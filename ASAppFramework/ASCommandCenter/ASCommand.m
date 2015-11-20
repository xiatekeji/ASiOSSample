//
//  ASCommand.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/18.
//  Copyright © 2015年 侠特科技. All rights reserved.
//

#import "ASCommand.h"

@implementation ASCommand

- (void)executeWithEvent: (id)event {
	@throw [NSException exceptionWithName: NSInvalidArgumentException reason: [[NSString alloc] initWithFormat: @"Unrecognizable event class: \"%@\".", NSStringFromClass([event class])] userInfo: nil];
}

@end
