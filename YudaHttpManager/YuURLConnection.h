//
//  YuURLConnection.h
//  YudaHttpManager
//
//  Created by luyuda on 15/1/15.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YuURLConnection : NSURLConnection

@property (nonatomic,assign) int tag;

@property (nonatomic,strong) NSString *urlName;

@end
