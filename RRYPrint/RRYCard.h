//
//  RRYCard.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseView.h"

@class RRYCardTextEditor;
@class RRYCardModel;
@class RRYCardSingleFace;

@interface RRYCard : RRYBaseView

@property (nonatomic, strong) RRYCardSingleFace *cardModel;  // 名片模型
@property (nonatomic, strong) RRYFont *font;
@property (nonatomic, strong) UIImageView *baseImage;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) RRYCardTextEditor *textEditor;


// 名片上添加logo／文字
- (void)addText:(NSString *)textStr ;

@end
