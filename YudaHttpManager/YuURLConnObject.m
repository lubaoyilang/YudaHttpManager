//
//  YuURLConnObject.m
//  YudaHttpManager
//
//  Created by luyuda on 15/1/15.
//  Copyright (c) 2015年 UThing. All rights reserved.
//

#import "YuURLConnObject.h"

@interface YuURLConnObject ()

@property (nonatomic,strong)YuURLConnection *yuConn;
@property (nonatomic,strong)NSMutableData   *yuData;
@property (nonatomic,assign)double     timeOut;
@property (nonatomic,assign)BOOL    isFinish;

@end

@implementation YuURLConnObject
@synthesize delegate;






- (void)start
{
    [_yuConn start];
    
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeOut * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (!_isFinish) {
            //No超时
            [_yuConn cancel];
            _yuConn = nil;
            _yuData = nil;
            if (delegate && [delegate respondsToSelector:@selector(netWorkdidFailWithConn:Mark:)]) {
                [delegate netWorkdidFailWithConn:@"服务器服务器超时,请检查您的网络" Mark:_yuConn.urlName];
            }
            
            
        }
        
        
    });

    
    
    

}


- (id)initConnWithURL:(NSString*)url timeOut:(double)time Body:(NSData*)body ConnName:(NSString*)name
{
    if (self = [super init]) {
        _isFinish = NO;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:time];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:body];
        
        _yuConn = [[YuURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        _yuConn.urlName = name;
        if (_yuConn) {
            _yuData = [[NSMutableData alloc] init];
        }
    }
 
    
    return self;
    
}





#pragma mark - NetDelegate



- (void)connection:(YuURLConnection *)connection didReceiveData:(NSData *)data {
    [_yuData appendData:data];
}

-(void)connection:(YuURLConnection *)connection didFailWithError:(NSError *)error {
    
    
    
    if (delegate && [delegate respondsToSelector:@selector(netWorkdidFailWithConn:Mark:)]) {
        [delegate netWorkdidFailWithConn:@"服务器连接失败,请检查您的网络" Mark:_yuConn.urlName];
    }
    
    _yuData = nil;
    _yuConn = nil;
    _isFinish = YES;
}



-(void)connectionDidFinishLoading:(YuURLConnection *)connection {

    _isFinish = YES;
    
    if (delegate && [delegate respondsToSelector:@selector(netWorkdidFinishWithData:Mark:)]) {
        [delegate netWorkdidFinishWithData:_yuData Mark:_yuConn.urlName];
    }
    
    _yuData = nil;
    _yuConn = nil;
    _isFinish = YES;

}









@end
