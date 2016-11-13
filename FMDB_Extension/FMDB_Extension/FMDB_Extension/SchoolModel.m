//
//  SchoolModel.m
//  FMDB_Extension
//
//  Created by ZhouYong on 16/11/11.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "SchoolModel.h"

@implementation SchoolModel

/*
 @property(nonatomic, strong)NSString* name;
 @property(nonatomic, strong)NSString* age;
 @property(nonatomic, strong)NSString* money;
 @property(nonatomic, strong)NSString* school;
 @property(nonatomic, strong)NSString* number;
 @property(nonatomic, strong)NSString* company;
 @property(nonatomic, strong)NSString* map;

 */
- (instancetype)init
{
    if (self = [super init]) {
        self.name = @"xiaoming";
        self.age = @"20";
        self.money = @"100元";
        self.school = @"SSPU";
        self.number = @"20124823566";
        self.company = @"KidStone";
        self.map = @"百度地图";
    }
    return self;
}

@end
