//
//  User.h
//  sertyh
//
//  Created by 李康 on 15/8/3.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dog;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSSet *dogship;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addDogshipObject:(Dog *)value;
- (void)removeDogshipObject:(Dog *)value;
- (void)addDogship:(NSSet *)values;
- (void)removeDogship:(NSSet *)values;

@end
