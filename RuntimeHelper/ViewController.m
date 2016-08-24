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
#import <objc/runtime.h>
#import <objc/message.h>
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *clickButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置button连点
//    self.clickButton.timeInterval = 2;
    
    //使用runtime 添加方法
//    [self addMethod];
    
    
}


/**
 *  使用rutime 给类添加 方法
 *
 *  @param sender
 */
void sayHello(id self, SEL _cmd)
{
    NSLog(@"Hello");
}

-(void)addMethod
{
    /**
    class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
    Class cls：我们需要一个class，比如我的[HLPerson class]。
    SEL name：这个很有意思，这个名字自己可以随意想，就是添加的方法在本类里面叫做的名字，但是方法的格式一定要和你需要添加的方法的格式一样，比如有无参数。
    IMP imp：IMP就是Implementation的缩写，它是指向一个方法实现的指针，每一个方法都有一个对应的IMP。这里需要的是IMP，所以你不能直接写方法，需要用到一个方法：
    const char *types：这一个也很有意思，我刚开始也很费解
     比如：”v@:”意思就是这已是一个void类型的方法，没有参数传入。
     再比如 “i@:”就是说这是一个int类型的方法，没有参数传入。
     再再比如”i@:@”就是说这是一个int类型的方法，又一个参数传入。
    */
//     class_addMethod([NSString class], @selector(sayHello2), (IMP)sayHello, "v@:");
    //class_addMethod 还有一个使用方式 使用这个方法获取IMP OBJC_EXPORT IMP class_getMethodImplementation(Class cls, SEL name)
    //这个方法也是runtime的方法，就是获得对应的方法的指针，也就是IMP。
    
    //调用例子
    [self _addSelfClassMethod];
    //[self _getClassMethod];
}
/**
 *  这个是viewcontroller的方法 使用runtime调用本类的方式
 */
- (void)_addSelfClassMethod{
    HLPerson *instance = [[HLPerson alloc] init];
    class_addMethod([HLPerson class], @selector(sayHello2), class_getMethodImplementation([ViewController class], @selector(addSelfClass)), "v@:");
    //因为performSelector是运行时系统负责去找方法的，在编译时候不做任何校验；如果直接调用编译是会自动校验。 添加方法是在运行时添加的，在编译的时候还没有这个本类方法，所以 不能使用直接调用
    [instance performSelector:@selector(sayHello2)];

}
-(void)addSelfClass
{

     NSLog(@"log---->%@",@"这个是使用runtime 在本类中添加的方法");

}

#pragma mark - 获取外部类的方法
- (void)_getClassMethod{
    HLPerson *instance = [[HLPerson alloc] init];
    //这里的test是HLPerson 里的方法 通过class_getMethodImplementation(Class cls, SEL name) 这个方法 可以在运行时获取到 外部类的所有方法 所以可以在这个类里调用外部类方法
    class_addMethod([HLPerson class], @selector(personHello), class_getMethodImplementation([HLPerson class], @selector(test)), "v@:");
    [instance performSelector:@selector(personHello)];

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
