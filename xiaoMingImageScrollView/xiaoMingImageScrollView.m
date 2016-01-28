//
//  xiaoMingImageScrollView.m
//  xiaoMingImageScrollView
//
//  Created by family on 16/1/18.
//  Copyright © 2016年 family. All rights reserved.
//

#import "xiaoMingImageScrollView.h"
#import "UIImageView+WebCache.h"
@interface xiaoMingImageScrollView()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
//当前显示的图片
@property(nonatomic,weak)UIImageView *currentImage;
//上一张显示的图片
@property(nonatomic,weak)UIImageView *leftImage;
//下一张显示的图片
@property(nonatomic,weak)UIImageView *rightImage;
@property(nonatomic,weak)UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation xiaoMingImageScrollView
//初始化入口
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        [self initSubView];
        [self tapClick];
    }
    return self;
}
#pragma  mark-点击手势
-(void)tapClick
{
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToClick)];
    [self addGestureRecognizer:tap];
}
-(void)tapToClick
{
    if ([self.delegate respondsToSelector:@selector(xiaoMingImageScrollViewCurrentPage:)]) {
        [self.delegate xiaoMingImageScrollViewCurrentPage:self.pageControl.currentPage];
    }
}
//初始化控件
-(void)initSubView
{
    //scrollView
    UIScrollView *scrollView =[[UIScrollView alloc]init];
    [self addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator =NO;
    scrollView.showsVerticalScrollIndicator =NO;
    scrollView.bounces =NO;
    scrollView.delegate =self;
    scrollView.pagingEnabled =YES;
    self.scrollView =scrollView;
    //leftImage
    UIImageView *leftImage =[[UIImageView alloc]init];
    [scrollView addSubview:leftImage];
    leftImage.userInteractionEnabled =YES;
    self.leftImage =leftImage;
    //currentImage
    UIImageView *currentImage =[[UIImageView alloc]init];
    [scrollView addSubview:currentImage];
    currentImage.userInteractionEnabled =YES;
    self.currentImage =currentImage;
    //rightImage
    UIImageView *rightImage =[[UIImageView alloc]init];
    [scrollView addSubview:rightImage];
    rightImage.userInteractionEnabled =YES;
    self.rightImage =rightImage;
    //pageControl
    UIPageControl *pageControl =[[UIPageControl alloc]init];
    [self addSubview:pageControl];
    self.pageControl =pageControl;
}
-(void)layoutSubviews
{
    CGFloat Height =self.frame.size.height;
    CGFloat Width =self.frame.size.width;
    self.scrollView.frame =self.bounds;
    self.scrollView.contentSize=CGSizeMake(3*Width, 0);
    self.leftImage.frame =CGRectMake(0, 0, Width, Height);
    self.currentImage.frame =CGRectMake(Width, 0, Width, Height);
    self.rightImage.frame =CGRectMake(2*Width, 0, Width, Height);
    self.pageControl.numberOfPages =self.imageArray.count;
    self.pageControl.currentPage =0;
    self.pageControl.frame =CGRectMake(0.5*Width-25, Height-25, 50, 20);
    [self update];
    [super layoutSubviews];
    [self layoutIfNeeded];
}
-(void)update
{
    NSInteger index =self.pageControl.currentPage;
    if (index == 0) {//当显示第一张的时候
        if ([self.imageArray[0]isKindOfClass:[NSString class]]) {//当为网络图片的时候
            [self.currentImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //timer只执行一次
                static dispatch_once_t oneToken;
                dispatch_once(&oneToken, ^{
                    [self startTimer];
                });
            }];
            [self.leftImage sd_setImageWithURL:[NSURL URLWithString:[self.imageArray lastObject]]];
            [self.rightImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[1]]];
        }else{
            self.currentImage.image =self.imageArray[0];
            self.leftImage.image =[self.imageArray lastObject];
            self.rightImage.image =self.imageArray[1];
        }
        self.currentImage.tag =0;
        self.leftImage.tag =self.imageArray.count-1;
        self.rightImage.tag =1;
    }else if (index == self.imageArray.count-1){//显示最后一张
        if ([self.imageArray[index]isKindOfClass:[NSString class]]) {
            [self.currentImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]]];
            [self.leftImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index-1]]];
            [self.rightImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]]];
        }else{
            self.currentImage.image =self.imageArray[index];
            self.rightImage.image =self.imageArray[0];
            self.leftImage.image =self.imageArray[index-1];
        }
        self.currentImage.tag =index;
        self.leftImage.tag =index-1;
        self.rightImage.tag =0;
    }else{
        if ([self.imageArray[index]isKindOfClass:[NSString class]]) {
            [self.currentImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]]];
            [self.leftImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index-1]]];
            [self.rightImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index+1]]];
        }else{
            self.currentImage.image =self.imageArray[index];
            self.rightImage.image =self.imageArray[index+1];
            self.leftImage.image =self.imageArray[index-1];
        }
        self.currentImage.tag =index;
        self.leftImage.tag =index-1;
        self.rightImage.tag =index+1;

    }
    self.scrollView.contentOffset =CGPointMake(self.frame.size.width, 0);
}
-(void)setCurrentIndex:(NSInteger)index andLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if ([self.imageArray[index]isKindOfClass:[NSString class]]) {
        [self.currentImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]]];
        [self.leftImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[leftIndex]]];
        [self.rightImage sd_setImageWithURL:[NSURL URLWithString:self.imageArray[rightIndex]]];
    }else{
        self.currentImage.image =self.imageArray[index];
        self.leftImage.image =self.imageArray[leftIndex];
        self.rightImage.image =self.imageArray[rightIndex];
    }
    self.currentImage.tag =index;
    self.leftImage.tag =leftIndex;
    self.rightImage.tag =rightIndex;
}
-(void)startTimer
{
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //比较三个图片离显示位置最短的距离,即为显示的图片
    CGFloat currentX =ABS(self.currentImage.frame.origin.x-scrollView.contentOffset.x);
    CGFloat leftX =ABS(self.leftImage.frame.origin.x-scrollView.contentOffset.x);
    CGFloat rightX =ABS(self.rightImage.frame.origin.x-scrollView.contentOffset.x);
    CGFloat temp =currentX<leftX?currentX:leftX;
      temp =temp<rightX?temp:rightX;
    if (temp == currentX) {
        self.pageControl.currentPage =self.currentImage.tag;
    }else if (temp ==leftX){
        self.pageControl.currentPage =self.leftImage.tag;
    }else if (temp ==rightX){
        self.pageControl.currentPage =self.rightImage.tag;
    }
}
//开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pause];
}
//结束拖拽
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
-(void)pause
{
    [self.timer invalidate];
    self.timer =nil;
}
-(void)nextPage
{
    [self. scrollView setContentOffset:CGPointMake(2*self.frame.size.width, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self update];
}
//自动定时跳转图片的时候也要重置一下
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self update];
}
-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray =imageArray;
}
@end
