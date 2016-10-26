//
//  WaterFlowLayout.m
//  瀑布流
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import "WaterFlowLayout.h"

/** 默认列数 */
static const NSInteger DefaultColumnCount = 3;
/** 每一列之间的间距 */
static const NSInteger DefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const NSInteger DefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets DefaultEdgeInsets = {0, 0, 0, 0};

@interface WaterFlowLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation WaterFlowLayout


/**
 *  初始化
 */
- (void)prepareLayout {
    [super prepareLayout];
    self.contentHeight = 0;
    //清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    //记录每一列的高度 一共3列
    for (NSInteger i = 0; i < DefaultColumnCount; i++) {
        [self.columnHeights addObject:@(DefaultEdgeInsets.top)];
        //        NSLog(@"%f",self.edgeInsets.top);
    }
    //清除之前所有布局属性
    [self.attrsArray removeAllObjects];
    //开始创建每一个cell对应发布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray addObject:attrs];
    }
}


/**
 *  决定cell的布局  prepareLayout后会调用一次,下面方法调用完毕修改cell属性后会再一次调用这个方法
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

/**
 *  返回每一个位置cell对应的布局属性 修改 self.attrsArray里面cell的属性,这个方法执行后再调用上一个方法
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    //设置布局属性的frame
    CGFloat w = (collectionViewW - DefaultEdgeInsets.left - DefaultEdgeInsets.right - (DefaultColumnCount - 1) * DefaultRowMargin) / DefaultColumnCount;
    CGFloat h = [self.delegate waterflowlayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
#pragma 核心代码
    //找出高度最短的那一列
    NSInteger destColumn = 0;
    //默认第一列最短
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < DefaultColumnCount; i++) {
        //取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        //minColumnHeight是最短那一列的高度,destColumn最短那一列
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat x = DefaultEdgeInsets.left + destColumn * (w + DefaultColumnMargin);
    CGFloat y = minColumnHeight;
    if (y != DefaultEdgeInsets.top) {
        y += DefaultRowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    //更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    //记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}

//整体的高度
- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + DefaultEdgeInsets.bottom);
}


- (NSMutableArray *)columnHeights {
    
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    
    return _columnHeights;
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

@end
