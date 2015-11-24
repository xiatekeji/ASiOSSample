//
//  ASSpecOptionVIewModel.m
//  ASIOSSample
//
//  Created by XiaoSong on 15/11/23.
//  Copyright © 2015年 XiaoSong. All rights reserved.
//

#import "ASSpecOptionViewModel.h"
#import "ASOptionModel.h"
@implementation ASSpecOptionViewModel
- (instancetype)init{
    self = [super init];
    if (self) {
        _option = ASSizeOption;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Option" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
        NSLog(@"dic=%@",dic);
        self.sizeOption = [[ASOptionViewModel alloc]init];
        self.sizeOption.currentIndex = [dic[@"size"][@"currentIndex"] integerValue];
        NSArray *array = dic[@"size"][@"options"];
        NSMutableArray *m_array = [[NSMutableArray alloc]initWithCapacity:array.count];
        for (int i = 0; i <array.count; i++) {
            NSDictionary *dic = array[i];
            ASOptionModel *model = [[ASOptionModel alloc]init];
            model.name = dic[@"name"];
            model.optionID = dic[@"optionID"];
            model.imageName = dic[@"imageName"];
            [m_array addObject:model];
        }
        self.sizeOption.options = [NSArray arrayWithArray:m_array];
        
        self.colorOption = [[ASOptionViewModel alloc]init];
        self.colorOption.currentIndex = [dic[@"color"][@"currentIndex"] integerValue];
        NSArray *arrayColor = dic[@"color"][@"options"];
        NSMutableArray *m_arrayColor = [[NSMutableArray alloc]initWithCapacity:arrayColor.count];
        for (int i = 0; i <arrayColor.count; i++) {
            NSDictionary *dic = arrayColor[i];
            ASOptionModel *model = [[ASOptionModel alloc]init];
            model.name = dic[@"name"];
            model.optionID = dic[@"optionID"];
            model.imageName = dic[@"imageName"];
            [m_arrayColor addObject:model];
        }
        self.colorOption.options = [NSArray arrayWithArray:m_arrayColor];
        
        self.coverOption = [[ASOptionViewModel alloc]init];
        self.coverOption.currentIndex = [dic[@"cover"][@"currentIndex"] integerValue];
        NSArray *arrayCover = dic[@"cover"][@"options"];
        NSMutableArray *m_arrayCover = [[NSMutableArray alloc]initWithCapacity:arrayCover.count];
        for (int i = 0; i <arrayCover.count; i++) {
            NSDictionary *dic = arrayCover[i];
            ASOptionModel *model = [[ASOptionModel alloc]init];
            model.name = dic[@"name"];
            model.optionID = dic[@"optionID"];
            model.imageName = dic[@"imageName"];
            [m_arrayCover addObject:model];
        }
        self.coverOption.options = [NSArray arrayWithArray:m_arrayCover];
    }
   
    return self;
}

- (ASOptionViewModel *)fetchOptionViewModelWithType:(ASOptionType)type{
    switch (type) {
        case ASSizeOption:
            return _sizeOption;
            break;
        case ASCoverOption:
             return _coverOption;
            break;
        case ASColorOption:
             return _colorOption;
            break;
        default:
             return _sizeOption;
            break;
    }
    
}
@end
