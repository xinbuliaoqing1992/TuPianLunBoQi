//
//  ViewController.m
//  图片轮播器
//
//  Created by James on 16/3/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import "ViewController.h"
#import "JYScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化UI
    [self initView];
    // Do any additional setup after loading the view, typically from a nib.
}

//初始化UI
- (void)initView {
    
    //初始化ScrollView
    JYScrollView *jyScrollView = [JYScrollView jyScrollViewWithFrame:[UIScreen mainScreen].bounds ContentOffset:CGPointMake(JYWindowWidth, 0) ContentSize:CGSizeMake(JYWindowWidth*3, 0) PagingEnabled:YES Bounces:YES ShowsHorizontalScrollIndicator:NO ShowsVerticalScrollIndicator:NO andImageDataArr:[NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"imageDataArr" ofType:@"plist"]]];
    
    [self.view addSubview:jyScrollView];
    
    //在这里添加“小点”控件的原因是避免“小点”控件和ScrollView一起滚动
    [self.view addSubview:jyScrollView.jyPageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
