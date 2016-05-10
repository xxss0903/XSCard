//
//  RRYNetworkTool.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/19.
//  Copyright © 2016年 rry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRYNetworkTool : NSObject

+ (instancetype)sharedNetworkTool;  // 单例 

+ (void)get:(NSString *)url andParam:(NSDictionary *)param success:(void (^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url andParam:(NSDictionary *)param success:(void (^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;

@end
