//
//  YuURLConnObject.h
//  YudaHttpManager
//
//  Created by luyuda on 15/1/15.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YuURLConnection.h"

@class YuURLConnObject;

@protocol URLConnProtocol <NSObject>

- (void)netWorkdidFailWithConn:(NSString*)errorMsg Mark:(id)name;
- (void)netWorkdidFinishWithData:(NSData*)da Mark:(id)name;

@end



@interface YuURLConnObject : NSObject



@property (nonatomic,weak)id<URLConnProtocol>delegate;


- (id)initConnWithURL:(NSString*)url timeOut:(double)time Body:(NSData*)body ConnName:(NSString*)name;

- (void)start;



@end
