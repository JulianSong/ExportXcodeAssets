# ExportXcodeAssets
导出Xcode中ImageAssets为OC

###使用
切换到需要输出的目录下
sh export_img_assets.sh  -o 输出目录 -n 输出名称"

###结果
```ruby
#import "JL_R.h"
#import <objc/runtime.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
NSString * dynamicMethodIMP(id self, SEL _cmd)
{
    return NSStringFromSelector(_cmd);
}
@implementation JL_R

+ (BOOL)resolveClassMethod:(SEL)sel
{
    Class selfMetaClass = objc_getMetaClass([NSStringFromClass([self class]) UTF8String]);
    class_addMethod(selfMetaClass, sel, (IMP) dynamicMethodIMP, "@@:");
    return YES;
}

+ (NSString *)dynamicMethodIMP
{
    return NSStringFromSelector(_cmd);
}
@end
#pragma clang diagnostic pop
```