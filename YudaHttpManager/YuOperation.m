//
//  YuOperation.m
//  YudaHttpManager
//
//  Created by luyuda on 15/1/16.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "YuOperation.h"

@interface YuOperation ()

@property (nonatomic,assign)BOOL isFinish;

@end

@implementation YuOperation




- (void)start
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_5_1) {
        // Make sure to run the runloop in our background thread so it can process downloaded data
        // Note: we use a timeout to work around an issue with NSURLConnection cancel under iOS 5
        //       not waking up the runloop, leading to dead threads (see https://github.com/rs/SDWebImage/issues/466)
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, false);
    }
    else {
        CFRunLoopRun();
    }
    
}


- (void)done
{
    
}

@end
