//
//  HeadView.m
//  CoreGraphics
//
//  Created by huangshan on 2017/5/4.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "HeadView.h"


@implementation HeadView

- (void)drawRect:(CGRect)rect {
    
    [self drawRect11:rect];
}

/** 
 
 1.若使用UIView绘图，只能在drawRect：方法中获取相应的contextRef并绘图。如果在其他方法中获取将获取到一个invalidate的ref并且不能用于画图。drawRect：方法不能手动显示调用，必须通过调用setNeedsDisplay 或者 setNeedsDisplayInRect，让系统自动调该方法。
 2.若使用calayer绘图，只能在drawLayer:inContext: 中（类似于drawRect）绘制，或者在delegate中的相应方法绘制。同样也是调用setNeedDisplay等间接调用以上方法
 3.若要实时画图，不能使用gestureRecognizer，只能使用touchbegan等方法来掉用setNeedsDisplay实时刷新屏幕
 
 */
//在UIKit的UIView中，UIView的主图层将delegate设置为UIView自己，会主动触发下面drawLayer函数，而drawLayer和drawRect只会触发一个来实现绘图操作
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//
//
//}


#pragma mark - 画文字

- (void)drawRect1:(CGRect)rect {
    
    //获得当前画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画线的宽度
    CGContextSetLineWidth(context, 0.25);
    
    //开始写字
    
    [@"我是文字" drawInRect:CGRectMake(10, 10, 100, 30) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //[@"" drawAtPoint:<#(CGPoint)#> withAttributes:<#(nullable NSDictionary<NSString *,id> *)#>]
    
}

#pragma mark - 画线条和填充

- (void)drawRect2:(CGRect)rect {
    
    //获得当前画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画线的宽度
    CGContextSetLineWidth(context, 4.5);
    
    //画线的划过的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    
    //设置填充的颜色
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    
    //移动到点
    CGContextMoveToPoint(context, 0.0f, 10.0f);
    
    //增加线条到点
    CGContextAddLineToPoint(context, 50.0f, 10.0f);
    
    //增加线条到点
    CGContextAddLineToPoint(context, 50.0f, 50.0f);
    
    //开始划线
    //CGContextStrokePath(context);
    
    //开始填充
    //CGContextFillPath(context);
    
    //注意：上面个的两个方法 CGContextStrokePath 和 CGContextFillPath 只能绘制一种，要不是形状路径，要不是填充路径，要两者都有，可以用下面的方法
    
    
    /**
     kCGPathFill, //只填充
     kCGPathEOFill,
     kCGPathStroke,
     kCGPathFillStroke,
     kCGPathEOFillStroke
     */
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

#pragma mark - 画圆

- (void)drawRect3:(CGRect)rect {
    
    //获得当前画板
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //画线条颜色颜色
    
    CGContextSetRGBStrokeColor(context, 0.2, 0.2, 0.2, 1.0);
    
    
    //线条的填充颜色
    
    CGContextSetRGBFillColor(context, 0.0f, 0.0f, 1.0f, 1.0f);
    
    
    //画线的宽度
    
    CGContextSetLineWidth(context, 1.0f);
    
    
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    
    
    
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    
    CGContextAddArc(context, 100, 26, 20, 0, 2*M_PI, 0); //添加一个圆
    
    //绘制形状路径 和方法 CGContextDrawPath(context, kCGPathStroke);类似
    
    //CGContextStrokePath(context);
    
    
    //绘制填充的路径 和方法 CGContextDrawPath(context, kCGPathFill);类似
    
    //CGContextFillPath(context);
    
    
    //注意：上面个的两个方法 CGContextStrokePath 和 CGContextFillPath 只能绘制一种，要不是形状路径，要不是填充路径，要两者都有，可以用下面的方法
    
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - 画阴影

- (void)drawRect4:(CGRect)rect {
    
    //获得当前画板
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //用UIKit层的UIBezierPath曲线来画线条
    UIBezierPath *btnPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20.0, 70.0, 200.0, 50) cornerRadius:4];
    
    //增加路径
    CGContextAddPath(context, btnPath.CGPath);
    
    //设置阴影，offset和模糊半径和颜色
    CGContextSetShadowWithColor(context, CGSizeMake(-1, -1), 3.0, [UIColor blackColor].CGColor);
    
    //设置阴影，offset和模糊半径
    //CGContextSetShadow(context, CGSizeMake(-8, -8), 3.0);
    
    //添加填充颜色
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    
    //填充路径，和下面的[btnPath fill]是一样的意思
    CGContextFillPath(context);
    
    //开始填充颜色
    //[btnPath fill];
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    //画制路径，和下面的[btnPath stroke]是一样的意思
    CGContextStrokePath(context);
    
    //[btnPath stroke];
    
}

#pragma mark - 绘制椭圆
- (void)drawRect5:(CGRect)rect {
    
    //获得当前画板
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画一个椭圆
    UIBezierPath *newPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(40.0, 150, 240, 50)];
    
    //裁切椭圆，将椭圆之外的区域裁切掉
    [newPath addClip];
    
    CGContextAddPath(context, newPath.CGPath);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextStrokePath(context);
    
}

#pragma mark - 渐变填充色

- (void)drawRect6:(CGRect)rect {
    
    //获得当前画板
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //渐变颜色
    NSArray *colors = @[(__bridge id)[UIColor colorWithRed:0.3 green:0.0 blue:0.0 alpha:0.2].CGColor,
                        (__bridge id)[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.8].CGColor];
    //颜色的分界线
    const CGFloat locations[] = {0.0, 0.5f};
    
    //创建渐变ref
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    //在图层中绘制渐变层，起始点和结束点
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0f, 0.0f), CGPointMake(0.0f, rect.size.height), 0);
    
}

#pragma mark - 用UIBezierPath绘制

- (void)drawRect7:(CGRect)rect {
    
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    
    //颜色填充
    //[[UIColor blueColor] setFill];
    
    //曲线填充
    //[p fill];
    
    //颜色描边
    [[UIColor blueColor] setStroke];
    
    //曲线描边
    [p stroke];
    
    /** 调用UIGraphicsPushContext 函数可以方便的将context：参数转化为当前上下文，记住最后别忘了调用UIGraphicsPopContext函数恢复上下文环境。
     
        当渲染path时，UIBezierPath实例的drawing属性会覆盖graphics context下的属性值。
     */
    
}

#pragma mark - 画三边粗细和颜色不一样的三边形

- (void)drawRect8:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /** 第一条边 */
    
    //移动到点
    CGContextMoveToPoint(context, 0.0f, 10.0f);
    
    //移动到点
    CGContextAddLineToPoint(context, 90.0f, 10.0f);
    
    //画线的划过的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    
    //画线的宽度
    CGContextSetLineWidth(context, 4.5);
    
    CGContextStrokePath(context);
    
    
    /** 第二条边 */

    //移动到点
    CGContextMoveToPoint(context, 90.0f, 10.0f);
    
    CGContextAddLineToPoint(context, 90.0f, 90.0f);

    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextSetLineWidth(context, 8.5);

    CGContextStrokePath(context);
    
    
    /** 第三条边 */

    CGContextMoveToPoint(context, 90.0f, 90.0f);

    CGContextAddLineToPoint(context, 0.0f, 10.0f);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextSetLineWidth(context, 14.5);

    CGContextStrokePath(context);

    
}

#pragma mark - 设置UIKit的填充函数

- (void)drawRect9:(CGRect)rect {

    //为当前的图形上下文设置要填充的颜色
    [[UIColor blueColor] setFill];
    
    //按照刚才设置的颜色进行填充矩形
    UIRectFill(rect);

    //设置图形上下文白色描边
    [[UIColor redColor] setStroke];

    //描边函数，按照刚才设置的颜色进行矩形描边
    UIRectFrame(rect);
    
    
    /** 
     UIRectFill(CGRect rect)：向当前绘图环境所创建的内存中的图片上填充一个矩形。
     
     UIRectFillUsingBlendMode(CGRect rect , CGBlendMode blendMode)：向当前绘图环境所创建的内存中的图片上填充一个矩形，绘制使用指定的混合模式。
     
     UIRectFrame(CGRect rect)：向当前绘图环境所创建的内存中的图片上绘制一个矩形边框。
     
     UIRectFrameUsingBlendMode(CGRect rect , CGBlendMode blendMode)：向当前绘图环境所创建的内存中的图片上绘制一个矩形边框，绘制使用指定的混合模式。
     
    上面4个方法都是直接绘制在当前绘图环境所创建的内存中的图片上，因此，这些方法都不需要传入CGContextRef作为参数。
     */
}

#pragma mark - 画布的平移变换

- (void)drawRect10:(CGRect)rect {
    
    //创建曲线
    UIBezierPath* aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 100)];
    
    //设置填充和描边颜色
    [[UIColor blackColor] setStroke];
    [[UIColor redColor] setFill];
    
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    
    //将画布平移
    CGContextTranslateCTM(aRef, 50, 50);
    
    //画布的旋转
    //CGContextRotateCTM(<#CGContextRef  _Nullable c#>, <#CGFloat angle#>)
    
    //画布的缩放
    //CGContextScaleCTM(<#CGContextRef  _Nullable c#>, <#CGFloat sx#>, <#CGFloat sy#>)
    
    //设置线条的宽度
    aPath.lineWidth = 5;
    
    //填充和描边
    [aPath fill];
    [aPath stroke];
}


- (void)drawRect11:(CGRect)rect {
    
    const CGFloat Scale = [UIScreen mainScreen].scale;
    GLsizei width = self.layer.bounds.size.width * Scale;
    GLsizei height = self.layer.bounds.size.height * Scale;
    
    GLubyte *imageData = (GLubyte *)calloc(width * height * 4, sizeof(GLubyte));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //初始化一块内存区域，用于存储图像纹理texture。建立绘图context。
    CGContextRef context = CGBitmapContextCreate(imageData, width, height, 8, width * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextScaleCTM(context, Scale, Scale);
    
    //因此时未能获取到所需要的图像UIImage，所以只能采用UIKit的截图方式，调用UIView的drawViewHierarchyInRect:afterScreenUpdates:从该view中截取图像。
    UIGraphicsPushContext(context);
    {
        [self drawViewHierarchyInRect:self.layer.bounds afterScreenUpdates:NO];
    }
    UIGraphicsPopContext();
    
    // 将当前layer渲染到image context中
    //[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];

    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    
    
}


@end
