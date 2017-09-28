//
//  SVURefreshFooter.m
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/11.
//  Copyright © 2017年 Insect. All rights reserved.
//

#import "SVURefreshFooter.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface SVURefreshFooter ()



@end

@implementation SVURefreshFooter

#pragma mark - Intial
- (void)prepare{
    
    [super prepare];

    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"上拉加载新的数据" forState:MJRefreshStateIdle];
    [self setTitle:@"松手，帮您加载数据" forState:MJRefreshStatePulling];
    [self setTitle:@"你好职大数据加载中" forState:MJRefreshStateRefreshing];
    //刷新控件出现多少时会进入刷新状态
    self.triggerAutomaticallyRefreshPercent = 0.5;
}

@end
