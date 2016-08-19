
#import <objc/runtime.h>
#import <objc/message.h>
#define encodeRuntime(A) \
\
unsigned int outCount = 0;\
Ivar *ivars = class_copyIvarList([self class], &outCount);\
for (unsigned int i = 0; i < outCount; ++i) {\
    Ivar ivar = ivars[i];\
    const void *name = ivar_getName(ivar);\
    NSString *ivarName = [NSString stringWithUTF8String:name];\
    ivarName = [ivarName substringFromIndex:1];\
    SEL getter = NSSelectorFromString(ivarName);\
    if ([self respondsToSelector:getter]) {\
        const void *typeEncoding = ivar_getTypeEncoding(ivar);\
        NSString *type = [NSString stringWithUTF8String:typeEncoding];\
        if ([type isEqualToString:@"r^v"]) {\
            const char *value = ((const void *(*)(id, SEL))(void *)objc_msgSend)((id)self, getter);\
            NSString *utf8Value = [NSString stringWithUTF8String:value];\
            [aCoder encodeObject:utf8Value forKey:ivarName];\
            continue;\
        }\
        else if ([type isEqualToString:@"i"]) {\
            int value = ((int (*)(id, SEL))(void *)objc_msgSend)((id)self, getter);\
            [aCoder encodeObject:@(value) forKey:ivarName];\
            continue;\
        }\
        else if ([type isEqualToString:@"f"]) {\
            float value = ((float (*)(id, SEL))(void *)objc_msgSend)((id)self, getter);\
            [aCoder encodeObject:@(value) forKey:ivarName];\
            continue;\
        }\
        id value = ((id (*)(id, SEL))(void *)objc_msgSend)((id)self, getter);\
        if (value != nil && [value respondsToSelector:@selector(encodeWithCoder:)]) {\
            [aCoder encodeObject:value forKey:ivarName];\
        }\
    }\
}\
free(ivars);\
\

#define initCoderRuntime(A) \
if (self = [super init]) {\
unsigned int outCount = 0;\
Ivar *ivars = class_copyIvarList([self class], &outCount);\
for (unsigned int i = 0; i < outCount; ++i) {\
    Ivar ivar = ivars[i];\
    const void *name = ivar_getName(ivar);\
    NSString *ivarName = [NSString stringWithUTF8String:name];\
    ivarName = [ivarName substringFromIndex:1];\
    NSString *setterName = ivarName;\
    if (![setterName hasPrefix:@"_"]) {\
        NSString *firstLetter = [NSString stringWithFormat:@"%c", [setterName characterAtIndex:0]];\
        setterName = [setterName substringFromIndex:1];\
        setterName = [NSString stringWithFormat:@"%@%@", firstLetter.uppercaseString, setterName];\
    }\
    setterName = [NSString stringWithFormat:@"set%@:", setterName];\
    SEL setter = NSSelectorFromString(setterName);\
    if ([self respondsToSelector:setter]) {\
        const void *typeEncoding = ivar_getTypeEncoding(ivar);\
        NSString *type = [NSString stringWithUTF8String:typeEncoding];\
        if ([type isEqualToString:@"r^v"]) {\
            NSString *value = [aDecoder decodeObjectForKey:ivarName];\
            if (value) {\
                ((void (*)(id, SEL, const void *))objc_msgSend)(self, setter, value.UTF8String);\
            }\
            continue;\
        }\
        else if ([type isEqualToString:@"i"]) {\
            NSNumber *value = [aDecoder decodeObjectForKey:ivarName];\
            if (value != nil) {\
                ((void (*)(id, SEL, int))objc_msgSend)(self, setter, [value intValue]);\
            }\
            continue;\
        } else if ([type isEqualToString:@"f"]) {\
            NSNumber *value = [aDecoder decodeObjectForKey:ivarName];\
            if (value != nil) {\
                ((void (*)(id, SEL, float))objc_msgSend)(self, setter, [value floatValue]);\
            }\
            continue;\
        }\
        id value = [aDecoder decodeObjectForKey:ivarName];\
        if (value != nil) {\
            ((void (*)(id, SEL, id))objc_msgSend)(self, setter, value);\
        }\
    }\
}\
free(ivars);\
}\
return self;\
\

