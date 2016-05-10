//
//  RRYCardTextField.h
//  RRYPrint
//
//  Created by xxss0903 on 16/4/9.
//  Copyright © 2016年 rry. All rights reserved.
//

#import "RRYBaseTextField.h"

@class RRYCard;

@interface RRYCardTextField : RRYBaseTextField

@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) RRYCard *card;
@property (nonatomic, strong) RRYFont *localFont;
//
//
//- (void)adjustTextFieldLength;
//- (void)showMenuController;

@end
