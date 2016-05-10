//
//  RRYNetworkTool.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/19.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYNetworkTool.h"

@implementation RRYNetworkTool

- (void)get:(NSString *)url
       andParam:(NSDictionary *)param
        success:(void (^)(NSDictionary *response))success
        failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url
      parameters:param
        progress:^(NSProgress * _Nonnull downloadProgress) {

        }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:0
                                                               error:nil];
        success(json);
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
             NSLog(@"error :%@", error);
    }];
    
}

/**
 *  请求数据的静态方法
 *
 *  @param url     url字符串
 *  @param param   参数
 *  @param success 成功的block回调
 *  @param failure 失败的block回调
 */
+ (void)get:(NSString *)url
       andParam:(NSDictionary *)param
        success:(void (^)(NSDictionary *response))success
        failure:(void (^)(NSError *error))failure
{
    [[self sharedNetworkTool] get:url
                         andParam:param
                          success:^(NSDictionary *response) {
                              success(response);  // 回调
                          }
                          failure:failure];
}


- (void)post:(NSString *)url
   andParam:(NSDictionary *)param
    success:(void (^)(NSDictionary *response))success
    failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

/**
 *  post请求方法
 *
 *  @param url     地址
 *  @param param   参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)post:(NSString *)url andParam:(NSDictionary *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [[self sharedNetworkTool] post:url andParam:param success:^(NSDictionary *response) {
        success(response);
    } failure:failure];
}

/**
 *  单例
 *
 *  @return 单例实例
 */
+ (instancetype)sharedNetworkTool
{
    static RRYNetworkTool *tool;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[RRYNetworkTool alloc] init];
    });
    return tool;
}

@end
