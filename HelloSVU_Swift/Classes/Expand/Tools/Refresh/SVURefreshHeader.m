//
//  SVURefreshHeader.m
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/11.
//  Copyright © 2017年 Insect. All rights reserved.
//

#import "SVURefreshHeader.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface SVURefreshHeader ()

@property (nonatomic , strong) UIImageView *refreshImage;

@end

@implementation SVURefreshHeader

#pragma mark - Intial
- (void)prepare {
    
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<= 60; i++) {
        UIImage *image = [UIImage imageNamed:@"icon_refresh_1"];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_refresh_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.stateLabel.textColor = [UIColor orangeColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"上拉加载新的数据" forState:MJRefreshStateIdle];
    [self setTitle:@"松手，帮您加载数据" forState:MJRefreshStatePulling];
    [self setTitle:@"你好职大数据加载中" forState:MJRefreshStateRefreshing];
    self.refreshImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"refresh"]];
    [self addSubview:self.refreshImage];
}

- (void)placeSubviews{
    
    [super placeSubviews];
    
    self.refreshImage.mj_w = 40;
    self.refreshImage.mj_h = 40;
    self.refreshImage.mj_x = 40;
    self.refreshImage.mj_y = 10;
}

@end
