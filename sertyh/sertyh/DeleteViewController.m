//
//  DeleteViewController.m
//  sertyh
//
//  Created by 李康 on 15/8/3.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "DeleteViewController.h"

@interface DeleteViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userName;
@end

@implementation DeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
    self.navigationItem.rightBarButtonItem = save;
    // Do any additional setup after loading the view from its nib.
}
- (void)delete{
    if (self.UserBlock) {
        _UserBlock(_userName.text);
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
