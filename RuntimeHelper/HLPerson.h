//
//  HLPerson.h
//  防止button连点
//
//  Created by houli on 16/8/18.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
//使用runtime 实现NSCoding的自动归档解档
@interface HLPerson : NSObject<NSCoding>

@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) int age;
@property(nonatomic,strong) NSString *address;
@end
