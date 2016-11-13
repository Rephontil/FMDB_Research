//
//  SchoolModel.h
//  FMDB_Extension
//
//  Created by ZhouYong on 16/11/11.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolModel : NSObject

/*
 [databaseQueue inDatabase:^(FMDatabase *db) {
 BOOL flag = [db executeUpdate:@"create table if not exists t_school(id integer primary key autoincrement, name text,age text,money text,shcool text,number integer)"];
 //给一张已经存在的表添加一个新的字段,采用这样的语句: @"ALTER TABLE %@ ADD %@ INTEGER",@"表名",@"新增字段".这种做法一定成功的!
 //警示:还有很多人说先将这个已经创建好的表删除掉,然后再在创建表的语句(create table)里面添加新的字段,经过我的多次实践,没有成功!!!没有成功!!!没有成功!!!我承认我很笨,OK?
 if (![db columnExists:@"company" inTableWithName:@"t_school"]){

 [db executeUpdate:@"ALERT TABLE t_school ADD company text"]; //给一个已经存在的表增加一个新的字段
 }
 if (![db columnExists:@"map" inTableWithName:@"t_school"]){

 [db executeUpdate:@"ALERT TABLE t_school ADD map text"]; //给一个已经存在的表增加一个新的字段
 }

 */

/**<#注释#>**/
@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* age;
@property(nonatomic, strong)NSString* money;
@property(nonatomic, strong)NSString* school;
@property(nonatomic, strong)NSString* number;
@property(nonatomic, strong)NSString* company;
@property(nonatomic, strong)NSString* map;




@end
