//
//  RMMultipleDelegates.m
//  RMMultipleDeleagteDemo
//
//  Created by RaoMeng on 2017/12/21.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import "RMMultipleDelegates.h"

@interface RMMultipleDelegates()<RMMultipleDelegatesDelegate>

@end

@implementation RMMultipleDelegates

+ (instancetype)shareHelper {
    
    static  RMMultipleDelegates *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[RMMultipleDelegates alloc]init];
    });
    return center;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _delegates = [NSPointerArray weakObjectsPointerArray]; // 创建弱引用代理代理数组
    }
    return self;
}

#pragma mark - 操作代理

- (void)addDelegate:(id<RMMultipleDelegatesDelegate>)delegate {
    if (delegate && ![_delegates.allObjects containsObject:delegate]) {
        [_delegates addPointer:(__bridge void*)delegate];
    }
}

-(void)removeDelegate:(id)delegate {
    
    NSUInteger index = [self getIndexFormDelegates:delegate]; // 获取要删除代理的下标
    if (index == NSNotFound) {
        return;
    }
    [_delegates removePointerAtIndex:index];
    [_delegates compact]; // 移除数组的NULL指针
}

/**
 获取下标位置

 @param delegate <#delegate description#>
 @return <#return value description#>
 */
- (NSUInteger)getIndexFormDelegates:(id)delegate {
    
    for (NSUInteger i = 0; i < _delegates.count; i++) {
        id tempDelegate = [_delegates pointerAtIndex:i];
        if (tempDelegate == delegate) {
            return i;
        }
    }
    return NSNotFound;
}

#pragma mark - 消息转发

// 在给程序添加消息转发功能以前，必须覆盖两个方法，即methodSignatureForSelector:和forwardInvocation:。methodSignatureForSelector:的作用在于为另一个类实现的消息创建一个有效的方法签名，必须实现，并且返回不为空的methodSignature，否则会crash。forwardInvocation:将选择器转发给一个真正实现了该消息的对象。

/**
 重写这个方法，这个对象中的数组能想要调用者的代理方法

 @param aSelector <#aSelector description#>
 @return <#return value description#>
 */
-(BOOL)respondsToSelector:(SEL)aSelector {
   
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    for (id delegate in _delegates) {
        // 数组中的代理准寻这个方法并实现了代理中的方法
        if (delegate && [delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

/**
重写方法签名，给数组中的方法签名

 @param aSelector <#aSelector description#>
 @return <#return value description#>
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature) {
        return signature;
    }
    [_delegates compact]; // 遍历之前记得清除野指针
    for (id delegate in _delegates) {
        if (!delegate) {
            continue;
        }
        signature = [delegate methodSignatureForSelector:aSelector];
        if (signature) {
            break;
        }
    }
    return signature;
}


/**
 数组中的准寻代理对象都能掉用

 @param anInvocation <#anInvocation description#>
 */
-(void)forwardInvocation:(NSInvocation *)anInvocation {
    
    SEL sel = [anInvocation selector];
    BOOL isRespond = NO;
    [_delegates compact];
    //遍历存储给个对象的代理，发送给每个要实现代理方法的对象
    for (id delegate in _delegates) {
        if (delegate && [delegate respondsToSelector:sel]) {
            [anInvocation invokeWithTarget:delegate]; // 发送方法
            isRespond = YES;
        }
    }
    if (!isRespond) {
        [self doesNotRecognizeSelector:sel]; // 未识别的方法抛异常，避免闪退
    }
}

- (void)sendData:(id)data {
    
    [self multipleDelegatesHelper:self sendeData:data];
    
}



@end
