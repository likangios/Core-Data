//
//  AddViewController.h
//  sertyh
//
//  Created by 李康 on 15/8/3.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

typedef void(^AddUserBlock)(NSString *user , NSNumber *age,NSString *dogname);

@interface AddViewController : UIViewController

@property (nonatomic,copy) AddUserBlock UserBlock;
@end
