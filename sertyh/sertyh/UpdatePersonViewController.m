//
//  UpdatePersonViewController.m
//  sertyh
//
//  Created by 李康 on 15/8/4.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "UpdatePersonViewController.h"

@interface UpdatePersonViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userAge;
@property (strong, nonatomic) IBOutlet UITextField *userDogNickName;
@property (strong, nonatomic) IBOutlet UITextField *addDogName;

@end

@implementation UpdatePersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userName.text = self.name;

    self.userDogNickName.text = self.nickname;

    self.userAge.text = [self.age stringValue];

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(ok)];
    self.navigationItem.rightBarButtonItem = item;
    
    // Do any additional setup after loading the view from its nib.
}
- (void)ok{
    if (self.updateBlock) {
        _updateBlock(_userName.text,[NSNumber numberWithInt:_userAge.text.intValue],_userDogNickName.text,_addDogName.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
