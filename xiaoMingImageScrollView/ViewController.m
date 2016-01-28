//
//  ViewController.m
//  xiaoMingImageScrollView
//
//  Created by family on 16/1/18.
//  Copyright © 2016年 family. All rights reserved.
//

#import "ViewController.h"
#import "xiaoMingImageScrollView.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<xiaoMingImageScrollViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    xiaoMingImageScrollView *scrollView = [[xiaoMingImageScrollView alloc]init];
    scrollView.frame =CGRectMake(50, 50, 300, 300);
    [self.view addSubview:scrollView];
//    UIImage *image1 =[UIImage imageNamed:@"1"];
//    UIImage *image2 =[UIImage imageNamed:@"2"];
//    UIImage *image3 =[UIImage imageNamed:@"3"];
//    UIImage *image4 =[UIImage imageNamed:@"4"];
//    UIImage *image5 =[UIImage imageNamed:@"5"];
//    NSArray *arr =@[image1,image2,image3,image4,image5];
    NSArray *arr =@[@"http://i.ksd-i.com/s/610*500_86400_4d03073ae34f6b5453279eb3a710f7ab/static.koreastardaily.com/2014-08-11/45875-253143.jpg",@"http://i2.sinaimg.cn/ent/y/k/2013-10-29/U7626P28T3D4032653F326DT20131029114844.jpg",@"http://img.idol001.com/origin/2015/06/16/bbf6ba704109508d217a0cdccb33f6401434431094.jpg",@"http://img2.kankan.kanimg.com/gallery2/block/2013/10/11/1734d8eae781c38aeaa6b06981a31b7c.jpg",@"http://p3.music.126.net/sYXaf0-2cpUwnC8T-Xgrpw==/3419481162394672.jpg"];
    scrollView.imageArray =arr;
    scrollView.delegate =self;
    //1.这是基于scrollView,设计它的scrollView的内容为左,中,右显示图片的宽高相等.创建一个pageControl,根据它的currentPage和选中的页数进行比较.如果当前页为0的话,那么它的左边为图片最大数量的一张,下一张为1.而当前页为最后一页的话,那么它左边为图片最大数量倒数第二张.右边为第一页.以上为特殊情况,分开设置.普通情况下,我们设置它当前页为index,左边为index-1,右边为index+1;
    //2.添加一个定时器(NSTimer),每一秒设置它的scrollView滚动到哪一个位置上.在UIScrollViewDelegate方法里决定定时器什么时候移除,什么时候添加.当结束拖拽的时候更新当前页数,定时器跳转下一页的时候更新当前页数(动画拖拽效果).
    
    
}
//根据点击手势来获得当前点击的页数
-(void)xiaoMingImageScrollViewCurrentPage:(NSInteger)index
{
    NSLog(@"%ld",index);
}

@end
