//
//  ViewController.m
//  sertyh
//
//  Created by 李康 on 15/8/3.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "Dog.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
@interface ViewController ()
{
    NSManagedObjectContext *_content;
}
@end

@implementation ViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _content =  [(AppDelegate *)([UIApplication sharedApplication].delegate) managedObjectContext];

    [self fetchAll];
}

- (void)updatePerson{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    NSArray *arr = [_content executeFetchRequest:request error:nil];
    for (User *user in arr) {
        user.age = @100;
    }
    if ([_content save:nil]) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败");
    }
}

- (void)fetchAll{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    NSArray *arr = [_content executeFetchRequest:request error:nil  ];
    for (User *user in arr) {
        NSLog(@"user.name %@",user.name);
        NSLog(@"user.age %d",user.age.intValue);
        for (Dog *dog in user.dogship) {
        NSLog(@"dog.nickname %@",dog.nickName);
        }
    }
}
- (User *)addUser:(User *)user{
    User *_user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:_content];
    _user.name = user.name;
    _user.age = user.age;
    [_user addDogshipObject:[self addDog]];
    if ([_content save:nil]) {
        NSLog(@"保存User成功");
    }else{
        NSLog(@"保存User失败");
    }
    return user;
}
- (Dog *)addDog{
    Dog *_dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:_content];
    _dog.nickName = @"dogOne";
    return _dog;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
