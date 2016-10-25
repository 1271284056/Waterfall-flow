//
//  UIImage+Extension.h
//  UI-01-图片轮播
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

- (void)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize completion:(void (^)(UIImage *))completion;

/// 根据当前图像，和指定的尺寸，生成圆角图像并且返回
- (void)cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius completion:(void (^)(UIImage *))completion;
@end
