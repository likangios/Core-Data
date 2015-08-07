//
//  UpdatePersonViewController.h
//  sertyh
//
//  Created by 李康 on 15/8/4.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdatePersonBlock)(NSString *newname,NSNumber *newAge,NSString *dognickname,NSString *addDogNickName);

@interface UpdatePersonViewController : UIViewController

@property (nonatomic,copy) UpdatePersonBlock updateBlock;

@property  (nonatomic,copy) NSString *name;

@property  (nonatomic,copy) NSString *nickname;

@property  (nonatomic,strong) NSNumber *age;
@end
