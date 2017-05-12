//
//  ViewController.m
//  WaveAnimation
//
//  Created by 张经兰 on 2016/11/2.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) float offset;
@property (nonatomic, assign) float waveHeight;
@property (nonatomic, assign) float waveWidth;
@property (nonatomic, assign) float h;
@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) CAShapeLayer *layer2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wave];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)wave
{
    _offset = 40.0;
    _speed = 5.0;
    _waveWidth = self.view.frame.size.width;
    _waveHeight = 10;
    _h = 10;
    
    UIView *middleview = [[UIView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200)];
    self.layer = [CAShapeLayer layer];
    self.layer2 = [CAShapeLayer layer];
    middleview.backgroundColor = [UIColor orangeColor];
    [middleview.layer addSublayer:self.layer];
    [middleview.layer addSublayer:self.layer2];
    [self.view addSubview:middleview];

    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAni)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)doAni
{
    _offset += _speed;
    //设置第一条波曲线的路径
    CGMutablePathRef pathRef = CGPathCreateMutable();
    //起始点
    CGFloat startY = _waveHeight*sinf(_offset*M_PI/_waveWidth);
    CGPathMoveToPoint(pathRef, NULL, 0, startY);
    //第一个波的公式
    for (CGFloat i = 0.0; i < _waveWidth; i ++) {
        CGFloat y = 1.1*_waveHeight*sinf(2.5*M_PI*i/_waveWidth + _offset*M_PI/_waveWidth) + _h;
        CGPathAddLineToPoint(pathRef, NULL, i, y);
    }
    CGPathAddLineToPoint(pathRef, NULL, _waveWidth, 40);
    CGPathAddLineToPoint(pathRef, NULL, 0, 40);
    CGPathCloseSubpath(pathRef);
    //设置第一个波layer的path
    _layer.path = pathRef;
    _layer.opacity = 0.5;
    _layer.fillColor = [UIColor lightGrayColor].CGColor;
    CGPathRelease(pathRef);
    
    //设置第二条波曲线的路径
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    CGFloat startY2 = _waveHeight*sinf(_offset*M_PI/_waveWidth + M_PI/4);
    CGPathMoveToPoint(pathRef2, NULL, 0, startY2);
    //第二个波曲线的公式
    for (CGFloat i = 0.0; i < _waveWidth; i ++) {
        CGFloat y = _waveHeight*sinf(2.5*M_PI*i/_waveWidth + 3*_offset*M_PI/_waveWidth + M_PI/4) + _h;
        CGPathAddLineToPoint(pathRef2, NULL, i, y);
    }
    CGPathAddLineToPoint(pathRef2, NULL, _waveWidth, 40);
    CGPathAddLineToPoint(pathRef2, NULL, 0, 40);
    CGPathCloseSubpath(pathRef2);
    
    _layer2.path = pathRef2;
    _layer2.opacity = 0.5;

    _layer2.fillColor = [UIColor lightGrayColor].CGColor;
   CGPathRelease(pathRef2);
}

@end
