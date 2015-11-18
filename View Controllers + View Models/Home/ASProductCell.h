//
//  ASProductCell.h
//  PhotoBook
//
//  Created by XiaoSong on 15/9/8.
//  Copyright (c) 2015年 Logictech . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASProductCell : UITableViewCell
- (void)loadDataWithImage:(NSString *)image andName:(NSString *)name;
+ (NSString *)productCell;
@end
