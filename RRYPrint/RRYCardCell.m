//
//  RRYCardCell.m
//  RRYPrint
//
//  Created by xxss0903 on 16/4/8.
//  Copyright © 2016年 rry. All rights reserved.
//  名片瀑布流的cell

#import "RRYCardCell.h"
#import "RRYCardTemplate.h"

@interface RRYCardCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation RRYCardCell

#pragma mark - 
/**
 *  设置名片
 *
 *  @param card 名片数据
 */
- (void)setCardTemplate:(RRYCardTemplate *)cardTemplate
{
    _cardTemplate = cardTemplate;
    
    // 请求网络图片
    NSString *imageStr = [NSString stringWithFormat:@"%@/upload/design/tplfiles/Thumbs/%@",kUrlBase, cardTemplate.TemplateThumb];
    NSURL *imageUrl = [NSURL URLWithString:imageStr];

    // 单元格设定完成后，刷新当前的按元格，获取高度
    [self.imageView sd_setImageWithURL:imageUrl
                      placeholderImage:nil
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 
                                CGSize tempSize = CGSizeMake(self.bounds.size.width, (image.size.height/image.size.width)*self.bounds.size.width);
                                self.cardTemplate.cardSize = tempSize;
                                 
                                 if (_block) {
                                     _block(tempSize, self);
                                 }
    }];
}

- (void)passSize:(passSizeBlock)block
{
    _block = block;
}

#pragma mark
//  懒加载视图
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
