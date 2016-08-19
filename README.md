# RuntimeHelper
# 使用runtime实现的简单帮助类
> 使用示例：  runtime的归档宏

     -(void)encodeWithCoder:(NSCoder *)aCoder
     {
      encodeRuntime(HLPerson);
     }
     -(instancetype)initWithCoder:(NSCoder *)aDecoder
     {
     initCoderRuntime(HLPerson);
     }
> button 使用示例
       //设置button连点
    self.clickButton.timeInterval = 2;
