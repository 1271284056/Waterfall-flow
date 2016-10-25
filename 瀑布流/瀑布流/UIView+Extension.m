//
//  UIView+Extension.m
//  
//
//  Created by teacher on 15/8/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
  
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidthS:(CGFloat)widthS{
    CGRect rect = self.frame;
    rect.size.width = widthS;
    self.frame = rect;
}

- (CGFloat)widthS{
    return self.frame.size.width;
}

- (void)setHeightS:(CGFloat)heightS{
    CGRect rect = self.frame;
    rect.size.height = heightS;
    self.frame = rect;
}

- (CGFloat)heightS{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size{
    return self.frame.size;
}


- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}


- (CGFloat)centerX{
    return self.center.x;
}



- (void)setCenterY:(CGFloat)centerY{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}


- (CGFloat)centerY{
    return self.center.y;
}


@end
