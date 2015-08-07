//
//  AddPersonViewController.m
//  sertyh
//
//  Created by 李康 on 15/8/3.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "AddPersonViewController.h"
#import "User.h"
#import "Dog.h"
#import "AppDelegate.h"

#import "AddViewController.h"
#import "DeleteViewController.h"
#import "UpdatePersonViewController.h"


@interface AddPersonViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSManagedObjectContext *_content;
    
    
    NSString *_updateUserName;

}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableViewData;
@property (strong, nonatomic) IBOutlet UIButton *Update;
@property (strong, nonatomic) IBOutlet UIButton *AllData;
@property (strong, nonatomic) IBOutlet UIButton *Delete;
@property (strong, nonatomic) IBOutlet UIButton *Add;
@end

@implementation AddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentdic = paths[0];
    
    NSString *filePath = [documentdic stringByAppendingPathComponent:@"dasf"];

    
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachepath = cachePaths[0];
    
    NSString *temPath = NSTemporaryDirectory();
    
    
   
    self.title = @"Core Data";
    _content =  [(AppDelegate *)([UIApplication sharedApplication].delegate) managedObjectContext];
    [self GetAllData:nil];
}

/**
 *  添加user
 *
 *  @param sender
 */
- (IBAction)AddUser:(id)sender {
    AddViewController *add =[[AddViewController alloc]init];
    
    [add  setUserBlock:^(NSString *username,NSNumber *age,NSString *dogname){
        [self addUserWithName:username Age:age DogName:dogname];
        [self GetAllData:nil];
    }];
    [self.navigationController pushViewController:add animated:YES];
}
/**
 *  删除user
 *
 *  @param sender <#sender description#>
 */
- (IBAction)DeleteUser:(id)sender {
    DeleteViewController *delet = [[DeleteViewController alloc]init];
    [delet setUserBlock:^(NSString *userName){
        [self deletUser:userName];
        
        [self GetAllData:nil];
    }];
    [self.navigationController pushViewController:delet animated:YES];
    
}
/**
 *  查找所有数据
 *
 *  @param sender <#sender description#>
 */
- (IBAction)GetAllData:(id)sender {
    _tableViewData = [NSMutableArray array];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    
    NSArray *arr = [_content executeFetchRequest:request error:nil];
    for (User *user in arr) {
        
        NSLog(@"\nuser.name %@---user.age %d\n",user.name,user.age.intValue);
        for (Dog *dog in user.dogship) {
            NSLog(@"user'dog.nickname %@",dog.nickName);
        }
        [_tableViewData addObject:user];
    }
    [self.tableView reloadData];
}
/**
 *  更新user信息
 *
 *  @param sender
 */
- (IBAction)UpdateUser:(id)sender {
   
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新user" message:@"要更新的userName" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show  ];
}




#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    User *user = (User *)_tableViewData[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Name:%@---Age:%d",user.name,user.age.intValue];
 __block  NSMutableString *nickname = [[NSMutableString alloc]init];
    [user.dogship enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        Dog *dog = (Dog *)obj;
        NSString *name = [NSString stringWithFormat:@"%@、",dog.nickName];
        [nickname appendString:name];
    }];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Dogs:%@",nickname];
    return cell;
}

#pragma mark Action
/**
 *  删除user
 *
 *  @param userName 要删除的name
 */
- (void)deletUser:(NSString *)userName{

   User *user = [self getUserWithName:userName];
    if (user) {
        [_content deleteObject:user];
        
        if( [_content save:nil]){
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    }else{
        NSLog(@"数据不存在");
    }

    
}
/**
 *  更新user
 */
- (void)updatePersonName:(NSString *)name  UpdateToName:(NSString *)upName upAge:(NSNumber *)age   AddDog:(NSString *)nickname{
    
    User *user = [self getUserWithName:_updateUserName];
    user.age = age;
    user.name = upName;
    if (nickname.length)
        [user addDogshipObject:[self addDog:nickname]];
    
    if ([_content save:nil]) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败");
    }
}
/**
 *  添加一个user
 *
 *  @param userName 名字
 *  @param age      年龄
 *  @param dogname  狗的名字
 *
 *  @return user对象
 */
- (User *)addUserWithName:(NSString *)userName Age:(NSNumber *)age DogName:(NSString *)dogname{
    User *_user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:_content];
    _user.name = userName;
    _user.age = age;
    [_user addDogshipObject:[self addDog:dogname]];
    if ([_content save:nil]) {
        NSLog(@"保存User成功");
    }else{
        NSLog(@"保存User失败");
    }
    return _user;
}
/**
 *  添加一条狗
 *
 *  @param dogname <#dogname description#>
 *
 *  @return <#return value description#>
 */
- (Dog *)addDog:(NSString *)dogname{
    Dog *_dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:_content];
    _dog.nickName = dogname;
    return _dog;
}

#pragma mark AlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        
        _updateUserName = textfield.text;
        if (!_updateUserName.length)
            return;
        User *user = [self getUserWithName:_updateUserName];
        if(user){
            UpdatePersonViewController *update = [[UpdatePersonViewController alloc]init];
            update.name = user.name;
            update.age = user.age;
            NSArray *arr = user.dogship.allObjects;
            Dog *dog = (Dog *)arr[0];
            update.nickname = dog.nickName;
            [update setUpdateBlock:^(NSString *newname,NSNumber *newAge,NSString *dognickname,NSString *addDogNickName){
                
                [self updatePersonName:_updateUserName UpdateToName:newname upAge:newAge AddDog:addDogNickName];
                
                [self GetAllData:nil];
                

            }];
            
            [self.navigationController pushViewController:update animated:YES];
            
        }
    }
}
/**
 *  根据name查找user
 *
 *  @param name username
 *
 *  @return user obj
 */
- (User *)getUserWithName:(NSString *)name{
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name= %@)",name];     //创建一个“查询”，寻找name=name的行
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    request.predicate = pred;
    
    NSArray *arr = [_content executeFetchRequest:request error:nil  ];
    if (arr.count)
    return (User *)arr[0];
    NSLog(@"未找到数据");
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
