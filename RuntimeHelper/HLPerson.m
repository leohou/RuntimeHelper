//
//  HLPerson.m
//  防止button连点
//
//  Created by houli on 16/8/18.
//  Copyright © 2016年 com. All rights reserved.
//

#import "HLPerson.h"
#import "RuntimeModelNscoding.h"
//#import "HLArchiveModel.h"
@implementation HLPerson

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    encodeRuntime(HLPerson);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{

    initCoderRuntime(HLPerson);
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"姓名: %@ 年龄: %d 地址:%@ float: %f number:%@ array:%@",_name,_age,_address,_loat,_number,_array];
}
-(void)test
{
    
    NSLog(@"log---->%@",@"我获取到Person里的方法了");
    
}


@end
