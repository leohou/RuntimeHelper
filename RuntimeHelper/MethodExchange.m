//
//  MethodExchange.m
//  RuntimeHelper
//
//  Created by houli on 16/8/26.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MethodExchange.h"
#import <objc/message.h>
@implementation MethodExchange

/**
 *  使用load 的原因是 因为 load只执行一次
 */
+(void)load
{

    //做方法交换
    [self _methodExchange];

}
/******************************* 方法交换begin ********************/
+ (void)_methodExchange{
    
    Method method1 = class_getInstanceMethod([MethodExchange class], @selector(exchangeMethod1));
    Method method2 = class_getInstanceMethod([MethodExchange class], @selector(exchangeMethod2));
    
    method_exchangeImplementations(method1, method2);
    
}

- (void) exchangeMethod1{
    
    NSLog(@"log---->%@",@"exchangeMethod1");
}

- (void)exchangeMethod2{
    NSLog(@"log---->%@",@"exchangeMethod2");
}

/******************************* 方法交换end **********************/


@end
