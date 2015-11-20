//
//  AppDelegate+CommandRegistry.m
//  ASIOSSample
//
//  Created by 傅立业 on 15/11/19.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "AppDelegate+CommandBinding.h"

#import "ASCommandCenter.h"

#import "ASSignInEvent.h"
#import "ASSignInCommand.h"

@implementation AppDelegate(CommandBinding)

- (void)bindCommands {
	ASCommandCenter* commandCenter = [ASCommandCenter defaultCenter];
	
	[commandCenter bindCommand: [ASSignInCommand class] toEvent: [ASSignInEvent class]];
	
	// TODO Register other commands.
}

@end
