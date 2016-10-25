//
//  UIImage+Extension.m
//  UI-01-图片轮播
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (void)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize completion:(void (^)(UIImage *))completion{
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIGraphicsBeginImageContextWithOptions(imgeSize, YES, 0);
        // 绘制图像
        [image drawInRect:CGRectMake(0, 0, imgeSize.width, imgeSize.height)];
        // 取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}



/**
 如何回调：block - iOS 开发中，block最多的用途就是在异步执行完成之后，通过参数回调通知调用方结果！
 */
- (void)cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius completion:(void (^)(UIImage *))completion{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //        NSTimeInterval start = CACurrentMediaTime();
        // 1. 利用绘图，建立上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // 2. 设置填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        
        // 3. 利用 贝赛尔路径 `裁切 效果
        //        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        UIBezierPath *path = [UIBezierPath  bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
        
        [path addClip];
        
        // 4. 绘制图像
        [self drawInRect:rect];
        
        // 5. 取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        // 6. 关闭上下文
        UIGraphicsEndImageContext();
        
        //        NSLog(@"%f", CACurrentMediaTime() - start);
        
        // 7. 完成回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}

@end
