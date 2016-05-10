//
//  RRYCardModel.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/14.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseModel.h"
@class RRYCardSingleFace;

@interface RRYCardModel : RRYBaseModel

@property (nonatomic, strong) NSMutableArray *PagesArray;    // 名片页面

@property (nonatomic, copy) NSString *Addtime;  // 添加时间
@property (nonatomic, copy) NSString *Author;   // 作者
@property (nonatomic, copy) NSString *FilePath; // 路径
@property (nonatomic, copy) NSString *GroupId;  // 组ID
@property (nonatomic, assign) BOOL IsRound;  // 是否圆角
@property (nonatomic, copy) NSString *Name; // 名片名称
@property (nonatomic, copy) NSString *PreviewId;    
@property (nonatomic, copy) NSString *SizeId;
@property (nonatomic, copy) NSString *TemplateNumber;
@property (nonatomic, copy) NSString *TypeId;
@property (nonatomic, copy) NSString *status;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cardModelWithDict:(NSDictionary *)dict;

@end
