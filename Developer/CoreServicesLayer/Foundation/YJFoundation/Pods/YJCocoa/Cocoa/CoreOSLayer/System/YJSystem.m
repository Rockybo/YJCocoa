//
//  YJSystem.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJSystem.h"

// 主线程运行
void dispatch_async_main(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

// 后台运行
void dispatch_async_background(dispatch_block_t block) {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, block);
}

// 异步UI执行
void dispatch_async_UI(dispatch_block_t block) {
    dispatch_async_background(^{
        dispatch_async_main(block);
    });
}

// 主线程延时执行
void dispatch_after_main(int64_t delayInSeconds, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

// 串行队列执行
void dispatch_sync_serial(const char *label, dispatch_block_t block) {
    // 串行队列：只有一个线程，加入到队列中的操作按添加顺序依次执行
    dispatch_sync(dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL), block);
}

// 并发队列
void dispatch_async_concurrent(dispatch_block_t block) {
    // 并发队列：有多个线程，操作进来之后它会将这些队列安排在可用的处理器上，同时保证先进来的任务优先处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}


@implementation YJSystem

@end