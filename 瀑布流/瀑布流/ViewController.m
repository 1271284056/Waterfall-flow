//
//  ViewController.m
//  瀑布流
//
//  Created by 张江东 on 16/10/25.
//  Copyright © 2016年 58kuaipai. All rights reserved.
//

#import "ViewController.h"
#import "TaoBaoModel.h"
#import "TaoBaoCell.h"
#import "WaterFlowLayout.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImage+Extension.h"
#import "UIImageView+WebCache.h"


static NSString * const ShopId = @"shop";

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,WaterFlowLayouttDelegate>


/** 所有的商品数据  */
@property (nonatomic, strong)NSMutableArray *shops;

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self setupRefresh];
 
}

- (void)setupRefresh {
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.mj_footer.hidden = YES;
    
    
}

- (void)loadNewShops {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        NSArray *shops = [JGShop mj_objectArrayWithFile:@"1.plist"];
        NSArray *shops = [TaoBaoModel mj_objectArrayWithFilename:@"1.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        
        //刷新数据
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        
    });
    
    
    
}

- (void)loadMoreShops {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shops = [TaoBaoModel mj_objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shops];
        
        //刷新数据
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        
        
    });
    
    
    
}

- (void)setupLayout {
    
    //创建布局
    WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
    layout.delegate = self;
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TaoBaoCell class]) bundle:nil] forCellWithReuseIdentifier:ShopId];
    self.collectionView = collectionView;
}



#pragma mark - <UICollectionViewDataSource> -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoBaoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopId forIndexPath:indexPath];
    cell.taoBaoM = self.shops[indexPath.item];
    return cell;
}

#pragma mark - <JGWaterflowLayoutDelegate> -高度
- (CGFloat)waterflowlayout:(WaterFlowLayout *)waterlayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    
    TaoBaoModel *model = self.shops[index];
    return itemWidth * model.h / model.w;
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%@",(long)indexPath.item,[self.shops[indexPath.item] price]);
}

- (NSMutableArray *)shops {
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

@end
