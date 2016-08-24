//
//  NSString+numberDivision.h
//  test
//
//  Created by houli on 16/8/23.
//  Copyright © 2016年 wzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (numberDivision)

/**
 *  格式化字符串3位一组(按位数取舍,没有入位)
 *
 *  @param numberObject 需要处理的字符串(可以是nsnumber)
 *  @param bits         保留的位数
 *
 *  @return 返回字符串
 */
+ (NSString *)numberDivision:(id)numberObject bits:(NSInteger)bits ;
/**
 *  格式化字符串3位一组(按位数取舍,没有入位)
 *
 *  @param numberObject 需要处理的字符串(可以是nsnumber)
 *  @param bits         保留的位数
 *  @param isInteger   是否自动保留整数(如 : yes 则 1.00 为 1)
 *  @return 返回字符串
 */
+ (NSString *)numberDivision:(id)numberObject bits:(NSInteger)bits isInteger:(BOOL)isInteger;


@end
