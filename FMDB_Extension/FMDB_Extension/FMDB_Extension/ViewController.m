//
//  ViewController.m
//  FMDB
//
//  Created by ZhouYong on 16/11/10.
//  Copyright © 2016年 Rephontil/Yong Zhou. All rights reserved.
//

#import "ViewController.h"
#import <FMDB.h>
#import "SchoolModel.h"

@interface ViewController ()<UITextFieldDelegate>

/**<*****#>*/
@property (nonatomic, strong)FMDatabaseQueue *databaseQueue;

@property (weak, nonatomic) IBOutlet UITextField *textfield;
/*要查找的文字*/
@property (nonatomic, strong)NSString *seatchText;
/*字典*/
@property (nonatomic, strong)NSMutableDictionary *mutableDic;

/**<#注释#>**/
@property(nonatomic, strong)SchoolModel* schoolModel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFMDBPath];
    self.textfield.delegate = self;

    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @"male", @"sex",
                                       @"20", @"age",
                                       @"tom", @"name",
                                       @"run", @"hobby", nil];
    self.mutableDic = mutableDic;

    self.schoolModel = [[SchoolModel alloc] init];
    //    NSLog(@"%@",self.mutableDic);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createFMDBPath{

    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlitePath = [docPath stringByAppendingPathComponent:@"author.sqlite"];
    NSString *sqliteTestPath1 = [docPath stringByAppendingString:@"author.sqlite"];


    NSLog(@"sqlitePath = %@\nsqliteTestPath1 = %@",sqlitePath,sqliteTestPath1);

#pragma stringByAppendingPathComponent  stringByAppendingString的区别看下面
    /*
     sqlitePath = /Users/tjk/Library/Developer/CoreSimulator/Devices/3A2868F4-AE82-4771-870A-AC7EDA7A1CDC/data/Containers/Data/Application/2F39C86F-9AB1-4680-92FA-C228B9829C8E/Documents/author.sqlite

     sqliteTestPath1 = /Users/tjk/Library/Developer/CoreSimulator/Devices/3A2868F4-AE82-4771-870A-AC7EDA7A1CDC/data/Containers/Data/Application/2F39C86F-9AB1-4680-92FA-C228B9829C8E/Documentsauthor.sqlite
     */



    FMDatabaseQueue *databaseQueue = [FMDatabaseQueue databaseQueueWithPath:sqlitePath];
    self.databaseQueue = databaseQueue;
    //    创建一张数据表
    [databaseQueue inDatabase:^(FMDatabase *db) {
//        BOOL flag = [db executeUpdate:@"create table if not exists t_table(id integer primary key autoincrement, name text,age text,money text,school text,number integer)"];
        BOOL flag = [db executeUpdate:@"create table if not exists t_ModelStoreTable(name text,age text,money text,school text,number text,company text, map text)"];


        //给一张已经存在的表添加一个新的字段,采用这样的语句: @"ALTER TABLE %@ ADD %@ INTEGER",@"表名",@"新增字段".这种做法一定成功的!
        //警示:还有很多人说先将这个已经创建好的表删除掉,然后再在创建表的语句(create table)里面添加新的字段,经过我的多次实践,没有成功!!!没有成功!!!没有成功!!!我承认我很笨,OK?
        /*
        if (![db columnExists:@"company" inTableWithName:@"t_table"]){

            [db executeUpdate:@"ALERT TABLE t_table ADD company text"]; //给一个已经存在的表增加一个新的字段
        }
        if (![db columnExists:@"map" inTableWithName:@"t_table"]){

            [db executeUpdate:@"ALERT TABLE t_table ADD map text"]; //给一个已经存在的表增加一个新的字段
        }
         */


        if (flag == YES) {
            NSLog(@"创建成功");

        }else{
            NSLog(@"创建失败");
        }
    }];
}

- (void)storeDataWithModel:(SchoolModel *)schoolModel
{
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
       BOOL insertModelData = [db executeUpdate:@"insert into t_ModelStoreTable (name,age,money,school,number,company,map)values(?,?,?,?,?,?,?)",schoolModel.name,schoolModel.age,schoolModel.money,schoolModel.school,schoolModel.number,schoolModel.company,schoolModel.map];
        NSLog(@"%@%@",schoolModel.name,schoolModel.map);

        if (insertModelData) {
            NSLog(@"模型数据存储成功!");
        }

    }];

}

//(name,age,money,school,number,company,map)


- (IBAction)increase:(UIButton *)sender {
//    [self.databaseQueue inDatabase:^(FMDatabase *db) {
//        //       BOOL insertData1 = [db executeUpdate:@"insert into t_author(name,age) values(?,?)",@"老虎",@"1000"];
//        //       BOOL insertData2 = [db executeUpdate:@"insert into t_author(name,age) values(?,?)",@"狮子",@"500"];
//        ////       BOOL insertDic = [db executeUpdate:@"insert into t_user" withParameterDictionary:self.mutableDic];
//        //        if (insertData1 == YES && insertData2 == YES ) {
//        //            NSLog(@"数据插入成功");
//        //        }
//
//        //        BOOL insertData1 = [db executeUpdate:@"insert into t_man(name,age,money) values(?,?,?)",@"老虎",@"1000",@"200"];
//        BOOL insertData5 = [db executeUpdate:@"insert into t_school(name,age,money,shcool,number,map,company) values(?,?,?,?,?,?,?)",@"老虎",@"1000",@"200",@"浮山中学",@1,@"安徽",@"Dwise"];
//
//        if (insertData5) {
//            NSLog(@"数据插入成功");
//        }
//
//    }];


    [self storeDataWithModel:self.schoolModel];

}


- (IBAction)delete:(UIButton *)sender {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        BOOL delete1 = [db executeUpdate:@"delete from t_author where name = ?",@"老虎"];
        BOOL delete2 = [db executeUpdate:@"delete from t_author where name = ?",@"狮子"];

        if (delete1 == YES && delete2 == YES) {
            NSLog(@"数据删除成功");
        }
    }];
}

//    进行多事件执行的时候，要将这些事件打包，并开启事物，处理完之后要提交！记得开启事物和提交、设置滚动！
- (IBAction)modify:(UIButton *)sender {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        //开启事物
        [db beginTransaction];
        //       BOOL modify1 = [db executeUpdate:@"update t_user set money = ? where name = ?",@10000,@"老虎"];
        //       BOOL modify2 = [db executeUpdate:@"update t_user set money = ? where name = ?",@50000,@"狮子"];
        BOOL modify = [db executeUpdate:@"update t_author set age = ? where name = ?",@50000,[NSString stringWithFormat:@"%@",self.textfield.text]];


        //        if (modify1 == YES && modify2 == YES) {
        if (modify == YES ) {

            NSLog(@"数据修改成功");
        }else{
            [db rollback];
        }
        [db commit];

    }];
}




- (IBAction)search:(UIButton *)sender {
    NSLog(@"%@",self.textfield.text);
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSLog(@"1");
        FMResultSet *dataResult = [db executeQuery:@"select* from t_ModelStoreTable"];
        while ([dataResult next]) {
            NSLog(@"2");
            NSString *name = [dataResult stringForColumn:@"name"];
            NSString *age = [dataResult stringForColumn:@"age"];
            NSString *school = [dataResult stringForColumn:@"school"];
            NSString *number = [dataResult stringForColumn:@"number"];
            NSString *money = [dataResult stringForColumn:@"money"];
            NSString *map = [dataResult stringForColumn:@"map"];
            NSString *company = [dataResult stringForColumn:@"company"];
            NSLog(@"name:%@ age:%@ company:%@ %@,%@ %@ %@",name,age,school, number,money,map, company);

        }
    }];
}



- (IBAction)comfirm:(UIButton *)sender {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete from t_ModelStoreTable"];  //删除这个表
    }];


}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.seatchText = textField.text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textfield endEditing:YES];
    
    
    
}



@end
