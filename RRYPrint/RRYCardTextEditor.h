//
//  RRYCardTextEditor.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/9.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseView.h"
#import "RRYFont.h"

@class RRYCard;
@class RRYCardText;

// 使用block传值
typedef  void (^FontBlock)(RRYFont *font);

@interface RRYCardTextEditor : RRYBaseView

@property (nonatomic, strong) RRYCard *card;
@property (nonatomic, strong) __block RRYFont *font;
@property (nonatomic, copy) FontBlock fontBlock;
@property (nonatomic, strong) RRYCardText *text;


- (void)passTextFont:(FontBlock)block;
+ (instancetype)sharedTextEditor;

@end
