# ExportXcodeAssets
导出Xcode中ImageAssets为OC

###使用
切换到需要输出的目录下
```ruby
sh export_img_assets.sh  -o 输出目录 -n 输出名称
```
###输出结果

####h文件
```ruby
#import <Foundation/Foundation.h>
@interface JL_R : NSObject
+ (NSString *)icon_league_basketball;
+ (NSString *)icon_league_football;
+ (NSString *)icon_league_other;
+ (NSString *)icon_play;
+ (NSString *)icon_search;
+ (NSString *)icon_selected;
+ (NSString *)icon_up_triangle_arrow;
+ (NSString *)image_no_data;
+ (NSString *)img_game_view_back;
+ (NSString *)tip_no_game;
+ (NSString *)icon_home_normal;
+ (NSString *)icon_home_on;
+ (NSString *)icon_me_normal;
+ (NSString *)icon_me_on;
+ (NSString *)icon_v_add_gm;
+ (NSString *)banner_signin;
+ (NSString *)icon_arrow_down;
+ (NSString *)icon_arrow_up;
+ (NSString *)icon_back_arrow;
+ (NSString *)icon_captcha;
+ (NSString *)icon_hupu_signin;
+ (NSString *)icon_password;
+ (NSString *)icon_phone;
+ (NSString *)icon_view_password;
+ (NSString *)icon_view_password_heighlight;
@end
```
####m文件
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
