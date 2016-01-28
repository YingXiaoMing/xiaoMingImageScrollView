//
//  xiaoMingImageScrollView.h
//  xiaoMingImageScrollView
//
//  Created by family on 16/1/18.
//  Copyright © 2016年 family. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol xiaoMingImageScrollViewDelegate<NSObject>
@optional
-(void)xiaoMingImageScrollViewCurrentPage:(NSInteger)index;
@end
@interface xiaoMingImageScrollView : UIView

@property(nonatomic,copy) NSArray *imageArray;
@property(nonatomic,weak)id<xiaoMingImageScrollViewDelegate> delegate;
@end
