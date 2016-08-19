//
//  ViewController.m
//  RuntimeHelper
//
//  Created by houli on 16/8/18.
//  Copyright © 2016年 com. All rights reserved.
//

#import "ViewController.h"
#import "HLPerson.h"
#import "UIButton+touch.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *clickButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置button连点
    self.clickButton.timeInterval = 2;
    
}


- (IBAction)clickActionButton:(id)sender {
    
//  [self _objKeyedArchiver];
    
    [self _objKeyedUnarchiver];
}


/**
 *  归档
 */
- (void)_objKeyedArchiver{

    HLPerson * model = [[HLPerson alloc]init];
    model.name =@"哈哈哈";
    model.age = 18;
    model.address = @"beijng";
    model.intesger = 19;
    model.number = [NSNumber numberWithInteger:13];
    model.loat = 0.8;
    model.array = @[@"123",@"456"];
    
        NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
    
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    
        [userd setObject:data forKey:@"person"];
    
        [userd synchronize];
}
/**
 *  解档
 */
- (void)_objKeyedUnarchiver{
    
    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
    
    NSData * data = [userd valueForKey:@"person"];
    
    HLPerson * per = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"log---->%@",[per description]);
}

@end
