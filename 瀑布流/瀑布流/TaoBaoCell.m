//
//  TaoBaoCell.m
//  瀑布流
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import "TaoBaoCell.h"
#import "TaoBaoModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"


@interface TaoBaoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@end

@implementation TaoBaoCell

- (void)setTaoBaoM:(TaoBaoModel *)taoBaoM{
    _taoBaoM = taoBaoM;
    // 1.图片
    
    UIImage *placeholder =  [UIImage imageNamed:@"loading"];
    [self.pic sd_setImageWithURL:[NSURL URLWithString:taoBaoM.img] placeholderImage:placeholder];
    
//    [self.pic sd_setImageWithURL:[NSURL URLWithString:taoBaoM.img] placeholderImage:[UIImage imageNamed:@"loading"] ];
    // 2.价格
    self.priceLb.text = taoBaoM.price;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //加上下面的代码会在滚动时候流畅一些
    //栅格化
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    // 异步绘制
    self.layer.drawsAsynchronously = YES;
}

@end
