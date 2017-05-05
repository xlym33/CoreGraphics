//
//  ViewController.m
//  CoreGraphics
//
//  Created by huangshan on 2017/5/4.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "ViewController.h"

#import "HeadView.h"

@interface ViewController ()<CALayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
        HeadView *headView = [[HeadView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
        headView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:headView];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 40, 40);
    layer.delegate = self;
    [headView.layer addSublayer:layer];
    [layer setNeedsDisplay];
    
    
//    [self test3];
    
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    
}

#pragma mark - 图片的平移绘制

- (void)test1 {
    
    UIImage *mars = [UIImage imageNamed:@"5"];
    
    CGSize sz = CGSizeMake(200, 200);
    
    //创建画布
    //UIGraphicsBeginImageContextWithOptions函数参数的含义：第一个参数表示所要创建的图片的尺寸；第二个参数用来指定所生成图片的背景是否为不透明，如上我们使用YES而不是NO，则我们得到的图片背景将会是黑色，显然这不是我想要的；第三个参数指定生成图片的缩放因子，这个缩放因子与UIImage的scale属性所指的含义是一致的。传入0则表示让图片的缩放因子根据屏幕的分辨率而变化，所以我们得到的图片不管是在单分辨率还是视网膜屏上看起来都会很好。
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height), NO, 0);
    
    //绘制一个区域，将图片绘制在rect内
    //[mars drawInRect:CGRectMake(80, 80, 100, 100)];
    
    //左上角的绘制点
    [mars drawAtPoint:CGPointMake(20, 20)];
    
    //有添加了一个绘制点
    [mars drawAtPoint:CGPointMake(140, 140)];
    
    //得到一个图片
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:im];
    
    imageView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview: imageView];
    
}

#pragma mark - 图片的缩放绘制

- (void)test2 {
    
    UIImage *mars = [UIImage imageNamed:@"5"];
    
    CGSize sz = CGSizeMake(200, 200);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width * 2, sz.height * 2), NO, 0);
    
    //绘制一个区域，将图片绘制在rect内
    //[mars drawInRect:CGRectMake(0, 0, sz.width * 2, sz.height * 2)];
    
    //使用UIImage的drawInRect函数，该函数内部能自动处理图片的正确方向，所以不会出现图片倒置的问题
    [mars drawInRect:CGRectMake(sz.width/2.0, sz.height/2.0, sz.width, sz.height) blendMode:kCGBlendModeMultiply alpha:1.0];
    
    //得到一个图片
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:im];
    
    imageView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview: imageView];
}

#pragma mark - 分割图片绘制

- (void)test3 {
    
    UIImage* mars = [UIImage imageNamed:@"5"];
    
    // 抽取图片的左右半边
    
    CGSize sz = [mars size];
    
    CGImageRef marsLeft = CGImageCreateWithImageInRect([mars CGImage],CGRectMake(0,0,sz.width/2.0,sz.height));
    
    CGImageRef marsRight = CGImageCreateWithImageInRect([mars CGImage],CGRectMake(sz.width/2.0,0,sz.width/2.0,sz.height));
    
    // 将每一个CGImage绘制到图形上下文中
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*1.5, sz.height), NO, 0);
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    //    CGContextRotateCTM(ctx, M_PI_4 * 0.3);
    //    CGContextScaleCTM(ctx, 0.5, 0.5);
    //    CGContextTranslateCTM(ctx, 0, 150);
    
    //处理图片倒置的问题
    CGContextTranslateCTM(con, 0, sz.height);
    CGContextScaleCTM(con, 1.0, -1.0);
    
    
    //现在回到问题，当通过CGContextDrawImage绘制图片到一个context中时，如果传入的是UIImage的CGImageRef，因为UIKit和CG坐标系y轴相反，所以图片绘制将会上下颠倒
    CGContextDrawImage(con, CGRectMake(0,0,sz.width/2.0,sz.height), marsLeft);
    
    CGContextDrawImage(con, CGRectMake(sz.width,0,sz.width/2.0,sz.height), marsRight);
    
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // 记得释放内存，ARC在这里无效
    
    CGImageRelease(marsLeft);
    
    CGImageRelease(marsRight);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:im];
    
    imageView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview: imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
