//
//  OTypes2.h
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

///网络操作状态
typedef NS_ENUM(NSInteger, ONetWorkState)
{
    ONetWorkFirst,//刚进界面的第一次网络操作  如果没加载成功 在请求网络就还是他
    ONetWorkTopPull,// 从上往下拉的刷新
    ONetWorkBottomPull// 从下往上拉的刷新
};
