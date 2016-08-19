//
//  UIButton+touch.h
//  RuntimeHelper
//
//  Created by houli on 16/8/18.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defaultInterval .5  //默认时间间隔
@interface UIButton (touch)
/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;

@end
