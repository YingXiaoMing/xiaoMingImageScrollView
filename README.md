# xiaoMingImageScrollView
123
#这是基于scrollView,设计它的scrollView的内容为左,中,右显示图片的宽高相等.创建一个pageControl,根据它的currentPage和选中的页数进行比较.如果当前页为0的话,那么它的左边为图片最大数量的一张,下一张为1.而当前页为最后一页的话,那么它左边为图片最大数量倒数第二张.右边为第一页.以上为特殊情况,分开设置.普通情况下,我们设置它当前页为index,左边为index-1,右边为index+1;
#添加一个定时器(NSTimer),每一秒设置它的scrollView滚动到哪一个位置上.在UIScrollViewDelegate方法里决定定时器什么时候移除,什么时候添加.当结束拖拽的时候更新当前页数,定时器跳转下一页的时候更新当前页数(动画拖拽效果).
