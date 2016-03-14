//
//  JYScrollView.h
//  图片轮播器
//
//  Created by James on 16/3/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYScrollView : UIScrollView

+ (JYScrollView *)jyScrollViewWithFrame:(CGRect)frame ContentOffset:(CGPoint)contentOffset ContentSize:(CGSize)contentSize PagingEnabled:(BOOL)pagingEnabled Bounces:(BOOL)bounces ShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator ShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator andImageDataArr:(NSMutableArray *)imageDataArr;

@property (strong, nonatomic) UIPageControl *jyPageControl;

@end
