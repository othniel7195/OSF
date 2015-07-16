//
//  NSNull+OVNatural.m
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "NSNull+OVNatural.h"

@implementation NSNull (OVNatural)

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

@end
