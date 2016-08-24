//
//  NSString+numberDivision.m
//  test
//
//  Created by houli on 16/8/23.
//  Copyright © 2016年 wzl. All rights reserved.
//

#import "NSString+numberDivision.h"

@implementation NSString (numberDivision)
+ (NSString *)numberDivision:(id)numberObject bits:(NSInteger)bits {
    
    NSString * number = [NSString stringWithFormat:@"%@",numberObject];
//    if ([NSString isBlankString:number]) {
//        NSLog(@"字符串为空,应该注意");
//    }
    
    //    if ([number containsString:@"."]) { 此方法iOS8以上可用
    if ([number rangeOfString:@"."].location != NSNotFound) {
        NSArray *arrNumber = [[NSArray alloc]initWithArray:[number componentsSeparatedByString:@"."]];
        NSMutableString *arrInt = [[NSMutableString alloc]initWithString:[arrNumber firstObject]];
        int index = 0;
        for (int i = 1; i <= arrInt.length; i ++) {
            if (i % 3 == 0 && arrInt.length > (i + index)) {
                [arrInt insertString:@"," atIndex:arrInt.length - (i + index)];
                index ++;
            }
        }
        if(bits != 0) {
            NSString *decimal = arrNumber.lastObject;
            if(decimal.length >= bits) {
                decimal = [decimal substringToIndex:bits];
            }else {
                while (decimal.length < bits) {
                    decimal = [decimal stringByAppendingString:@"0"];
                }
            }
            return [NSString stringWithFormat:@"%@.%@",arrInt,decimal];
        }else {
            return [NSString stringWithFormat:@"%@",arrInt];
        }
        
    } else {
        NSMutableString *arrInt = [[NSMutableString alloc]initWithString:number];
        int index = 0;
        for (int i = 1; i <= arrInt.length; i ++) {
            if (i % 3 == 0 && arrInt.length > (i + index)) {
                [arrInt insertString:@"," atIndex:arrInt.length - (i + index)];
                index ++;
            }
        }
        if(bits != 0) {
            NSString *decimal = [NSString stringWithFormat:@"%@",@"0"];
            while (decimal.length < bits) {
                decimal = [decimal stringByAppendingString:@"0"];
            }
            return [NSString stringWithFormat:@"%@.%@",arrInt,decimal];
        }else {
            return [NSString stringWithFormat:@"%@",arrInt];
        }
    }
}

+ (NSString *)numberDivision:(id)numberObject bits:(NSInteger)bits isInteger:(BOOL)isInteger {
    NSString *number = [NSString numberDivision:numberObject bits:bits];
    if ([number rangeOfString:@"."].location != NSNotFound) {
        NSArray *numberArray = [number componentsSeparatedByString:@"."];
        NSString *decimal = numberArray.lastObject;
        if(decimal.length >1) {
            if (decimal.floatValue == 0) {
                return numberArray.firstObject;
            }
            NSString *tempString = nil;
            NSInteger offset = decimal.length - 1;
            while (offset) {
                tempString = [decimal substringWithRange:NSMakeRange(offset, 1)];
                if ([tempString isEqualToString:@"0"] ) {
                    offset --;
                }else {
                    break;
                }
                decimal = [decimal substringToIndex:offset ];
                return [NSString stringWithFormat:@"%@.%@",numberArray.firstObject,decimal];
            }
        }else {
            if ([decimal isEqualToString:@"0"]) {
                return numberArray.firstObject;
            }else {
                return number;
            }
        }
        
    }else {
        return number;
    }
    return number;
}

@end
