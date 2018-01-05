//
//  RMMultipleDelegates.h
//  RMMultipleDeleagteDemo
//
//  Created by RaoMeng on 2017/12/21.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMMultipleDelegates;

/**
 自定义代理
 */
@protocol RMMultipleDelegatesDelegate <NSObject>

@optional

- (void) multipleDelegatesHelper:(RMMultipleDelegates *)helper sendeData:(id)data;

@end

@interface RMMultipleDelegates : NSObject

+ (instancetype)shareHelper;

// NSPointerArray弱引用数组，当对象被释放之后数组同时也会被置为NULL
@property (nonatomic, readonly, strong) NSPointerArray *delegates;

/**
 添加代理

 @param delegate <#delegate description#>
 */
- (void)addDelegate:(id<RMMultipleDelegatesDelegate>)delegate;

/**
 移除代理

 @param delegate <#delegate description#>
 */
- (void)removeDelegate:(id<RMMultipleDelegatesDelegate>)delegate;


/**
 发送消息

 @param data <#data description#>
 */
- (void)sendData:(id)data;


@end
