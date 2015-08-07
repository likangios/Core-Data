//
//  AddViewController.m
//  sertyh
//
//  Created by 李康 on 15/8/3.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()<UITextFieldDelegate>
{
    User *_user;
}
@property (strong, nonatomic) IBOutlet UITextField *UserDogTextField;
@property (strong, nonatomic) IBOutlet UITextField *UserAgeTextField;
@property (strong, nonatomic) IBOutlet UITextField *UserNameTextField;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.UserAgeTextField.delegate = self;
    self.UserNameTextField.delegate = self;
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = save;
    // Do any additional setup after loading the view from its nib.
}
- (void)save{

    
    if (self.UserBlock) {
        _UserBlock(_UserNameTextField.text , [NSNumber numberWithInt:_UserAgeTextField.text.intValue],_UserDogTextField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _UserNameTextField) {
        [_UserAgeTextField becomeFirstResponder];
        return YES;
    }
    return YES;
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
