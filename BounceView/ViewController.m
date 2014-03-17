//
//  ViewController.m
//  BounceView
//
//  Created by Xchobo on 2014/3/17.
//  Copyright (c) 2014年 Xchobo. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (retain, nonatomic) UIView *bounceView;
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UIButton *contentBtn;


- (IBAction)showViewBtn:(id)sender;

@end

@implementation ViewController

//按鈕動作要呼叫的程式: 播完動畫才會關閉視窗
- (void)closeView:(id)sender {
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = 0.4;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.00f, 0.00f, 0.00f)]];
    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = self;
    [_bounceView.layer addAnimation:hideAnimation forKey:nil];
}
// 由此關閉 _bounceView 視窗
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_bounceView removeFromSuperview];
}

- (void)openView{
    _bounceView.center = self.view.center;
    [self.view addSubview:_bounceView];
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.9;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.93f, 0.93f, 0.9f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.15f, @0.6f, @0.8f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_bounceView.layer addAnimation:popAnimation forKey:nil];
}

- (IBAction)showViewBtn:(id)sender {
    // 出現 _bounceView
    [self openView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //- viewDidLoad
    // 因為 _bounceView 會覆蓋整個畫面，但因為是透明的，所以可以看到以下的畫面
    _bounceView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [_bounceView setBackgroundColor:[UIColor clearColor]];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(40, 120, 240, 160)];
    [_contentView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    _contentView.layer.cornerRadius = 15.0f;
    _contentView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.9].CGColor;
    _contentView.layer.borderWidth = 3.0f;
    
    //建立 Button 元件
    _contentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_contentBtn setFrame:CGRectMake(80, 110, 80, 30)];
    [_contentBtn setTitle:@"關閉" forState:UIControlStateNormal];
    
    //按鈕動作
    [_contentBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    
    //將元件加入畫面
    [_contentView addSubview: _contentBtn];
    [_bounceView addSubview:_contentView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
