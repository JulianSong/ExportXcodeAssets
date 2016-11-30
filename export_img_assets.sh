#!/bin/sh
#获取当前目录
dir="$(pwd)";
imgset="imageset"

#usage 
usage="usage:sh export_img_assets.sh  -o 输出目录 -n 输出名称"

#参数模式
param_pattern=":n:o:h"
while getopts $param_pattern opt
do
        case $opt in
                o ) 
                    output_path=$OPTARG;;
                n ) 
                    output_name=$OPTARG;;
                h )
                    printf "${usage}"
                    exit 0;;
                ? ) echo "unkonw option $OPTIND"
                    exit 1;;
        esac
done

if [[ $# -eq 0 ]]; then
  printf "${usage}"
  exit 1 
fi
   
if [[ -z ${output_name} ]]; then
  echo "请输入输出文件名"
  exit 1
fi
if [[ -z ${output_path} ]]; then
  echo "请输入输出目录"
  exit 1
fi
output_h_file_Path=${output_path}"/"${output_name}".h"
output_m_file_Path=${output_path}"/"${output_name}".m"
> ${output_h_file_Path}
> ${output_m_file_Path}
echo ${output_h_file_Path}
echo ${output_m_file_Path}
#输出h文件头部
function outputHeader
{
  echo "//
//  ${output_name}.h
//  Do not edit generate automatically
//
" >> ${output_h_file_Path}
	echo "#import <Foundation/Foundation.h>" >> ${output_h_file_Path}
	echo "@interface ${output_name} : NSObject" >> ${output_h_file_Path}
}

#输出h文件内容
function outputImageset
{
	for subdir in `ls .`
	 do
	   if [ -d ${subdir} ]
	   then

	     dirExt=${subdir##*.}
	     if [ $dirExt = $imgset ]; then
	     	echo "+ (NSString *)${subdir%.*};" >> ${output_h_file_Path}
	     	# echo ${subdir}
	     	# echo ${dirExt}
	     fi
	     cd ${subdir}
	     outputImageset
	     cd ..
	   fi
	done 
}

#输出h文件尾部
function outputEnd
{
	echo "@end"  >> ${output_h_file_Path}
}

#输出n文件尾部
function outputMFile
{
    echo "//
//  ${output_name}.h
//  Do not edit generate automatically
//" >> ${output_m_file_Path}
	echo "
#import \"${output_name}.h\"
#import <objc/runtime.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored \"-Wincomplete-implementation\"
NSString * dynamicMethodIMP(id self, SEL _cmd)
{
    return NSStringFromSelector(_cmd);
}
@implementation ${output_name}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    Class selfMetaClass = objc_getMetaClass([NSStringFromClass([self class]) UTF8String]);
    class_addMethod(selfMetaClass, sel, (IMP) dynamicMethodIMP, \"@@:\");
    return YES;
}

+ (NSString *)dynamicMethodIMP
{
    return NSStringFromSelector(_cmd);
}
@end
#pragma clang diagnostic pop" >> ${output_m_file_Path}
}

outputHeader
outputImageset
outputEnd
outputMFile
