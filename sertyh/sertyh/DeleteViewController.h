//
//  DeleteViewController.h
//  sertyh
//
//  Created by 李康 on 15/8/3.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteUserBlock)(NSString *username);

@interface DeleteViewController : UIViewController

@property (nonatomic,copy) DeleteUserBlock UserBlock;

@end
