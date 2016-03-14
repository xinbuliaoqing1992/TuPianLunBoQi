//
//  JYScrollView.m
//  图片轮播器
//
//  Created by James on 16/3/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import "JYScrollView.h"
#import "UIImageView+WebCache.h"

int _currentImageIndex = 0;

#define JYScrollViewWidth  [UIScreen mainScreen].bounds.size.width
#define JYScrollViewHeight [UIScreen mainScreen].bounds.size.height

@interface JYScrollView() <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *leftImageView;

@property (strong, nonatomic) UIImageView *centerImageView;

@property (strong, nonatomic) UIImageView *rightImageView;

@property (strong, nonatomic) NSMutableArray *imageUrlArr;

@property (strong, nonatomic) NSTimer *jyTimer;

@end

@implementation JYScrollView

+ (JYScrollView *)jyScrollViewWithFrame:(CGRect)frame ContentOffset:(CGPoint)contentOffset ContentSize:(CGSize)contentSize PagingEnabled:(BOOL)pagingEnabled Bounces:(BOOL)bounces ShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator ShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator andImageDataArr:(NSMutableArray *)imageDataArr {
    
    JYScrollView *jyScrollView = [[JYScrollView alloc] initWithFrame:frame];
    
    jyScrollView.contentOffset = contentOffset;
    
    jyScrollView.contentSize = contentSize;
    
    jyScrollView.pagingEnabled = pagingEnabled;
    
    jyScrollView.bounces = bounces;
    
    jyScrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
    
    jyScrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
    
    jyScrollView.delegate = jyScrollView;
    
    jyScrollView.imageUrlArr = [NSMutableArray arrayWithArray:imageDataArr];
    
    //初始化3个ImageView
    [jyScrollView initImageView];
    
    //刷新ImageView
    [jyScrollView refreshImageView];
    
    //初始化小点
    [jyScrollView initJYPageControl];
    
    //初始化NSTimer
    [jyScrollView initTimer];
    
    return jyScrollView;
    
}


//初始化3个ImageView
- (void)initImageView {
    
    //最左面的ImageView
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, JYScrollViewWidth, JYScrollViewHeight)];
    
    [self addSubview:_leftImageView];
    
    
    //中间的ImageView
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(JYScrollViewWidth, 0, JYScrollViewWidth, JYScrollViewHeight)];
    
    [self addSubview:_centerImageView];
    
    
    //右面的ImageView
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(JYScrollViewWidth*2, 0, JYScrollViewWidth, JYScrollViewHeight)];
    
    [self addSubview:_rightImageView];
                        
}


//刷新ImageView
- (void)refreshImageView {
    
    //最左面的ImageView
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlArr[(_currentImageIndex-1+_imageUrlArr.count)%_imageUrlArr.count]] placeholderImage:nil];
    
    
    //中间的ImageView
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlArr[_currentImageIndex]] placeholderImage:nil];
    
    
    //右面的ImageView
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlArr[(_currentImageIndex+1)%_imageUrlArr.count]] placeholderImage:nil];
}


//初始化小点
- (void)initJYPageControl {
    _jyPageControl = [[UIPageControl alloc] init];
    
    _jyPageControl.numberOfPages = _imageUrlArr.count;
    
    _jyPageControl.currentPage = 0;
    
    _jyPageControl.userInteractionEnabled = NO;
    
    _jyPageControl.currentPageIndicatorTintColor = [UIColor greenColor];

    _jyPageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    CGSize jyPageControlSize = [_jyPageControl sizeForNumberOfPages:_jyPageControl.numberOfPages];
    
    _jyPageControl.frame = CGRectMake(JYWindowWidth/2-jyPageControlSize.width/2, JYWindowHeight-jyPageControlSize.height-20, jyPageControlSize.width, jyPageControlSize.height);
}


//改变小点的值
- (void)changePageControlValue {
    _jyPageControl.currentPage = _currentImageIndex;
}


//初始化NSTimer
- (void)initTimer {
    _jyTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
    
     [[NSRunLoop currentRunLoop] addTimer:_jyTimer forMode:NSRunLoopCommonModes];
    
}


//自动播放图片
- (void)autoPlay {
    
    [self setContentOffset:CGPointMake(JYScrollViewWidth*2, 0) animated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}


//当手点击屏幕时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_jyTimer invalidate];
    _jyTimer = nil;
}


//手指离开屏幕时
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self initTimer];
}


//当手离开屏幕时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //图片向左滚动
    if (self.contentOffset.x < JYScrollViewWidth) {
        _currentImageIndex = (int)(_currentImageIndex - 1+_imageUrlArr.count)%_imageUrlArr.count;
        
        //更新ImageView
        [self refreshImageView];
    }
    
    
    //图片向右滚动
    if (self.contentOffset.x > JYScrollViewWidth) {
        _currentImageIndex = (int)(_currentImageIndex + 1)%_imageUrlArr.count;
        
        //更新ImageView
        [self refreshImageView];
    }
    
    [self setContentOffset:CGPointMake(JYScrollViewWidth, 0)];
    
    [self changePageControlValue];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
