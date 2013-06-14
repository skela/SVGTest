//
//  ViewController.m
//  SVGTest
//
//  Created by Aleksander Slater on 14/06/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

//#import "CKSVGView.h"
#import "SVGKFastImageView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize currentScale;
@synthesize currentImage;

//@synthesize svgView;
@synthesize fimgView;
@synthesize activeView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer*tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [self.view addGestureRecognizer:tapper];
    [tapper release];
    
    UITapGestureRecognizer*dtapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerTappedView:)];
    dtapper.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:dtapper];
    [dtapper release];
    
    [self loadSubviews];
}

- (NSArray*)svgFiles
{
    NSString *svgFolder = [[NSBundle mainBundle] pathForResource:@"SVGs" ofType:nil];
    NSArray*svgFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:svgFolder error:nil];
    return svgFiles;
}

- (NSString*)currentSVGFile
{
    NSString *imageBundleName = nil;
    NSArray*svgFiles = self.svgFiles;
    if (svgFiles!=nil && [svgFiles count]>0)
    {
        NSString *svgFile = [svgFiles objectAtIndex:currentImage];
        imageBundleName = [NSString stringWithFormat:@"SVGs/%@",svgFile];
    }
    return imageBundleName;
}

- (void)loadSubviews
{
    if (fimgView!=nil)
    {
        [fimgView removeFromSuperview];
        [self setFimgView:nil];
    }
    /*
    if (svgView!=nil)
    {
        [svgView removeFromSuperview];
        [self setSvgView:nil];
    }*/
    
    NSString *imageBundleName = self.currentSVGFile;
    
    SVGKImage *svgkImg = [SVGKImage imageNamed:imageBundleName];
    fimgView = [[SVGKFastImageView alloc] initWithSVGKImage:svgkImg];
    fimgView.layer.borderColor = [UIColor greenColor].CGColor;
    fimgView.layer.borderWidth = 2.0;
    fimgView.alpha = 1.0;
    activeView = fimgView;
    [self.view addSubview:fimgView];
    
    //svgView = [[CKSVGView alloc] initWithName:imageBundleName];
    //svgView.layer.borderColor = [UIColor redColor].CGColor;
    //svgView.layer.borderWidth = 2.0;
    //svgView.alpha = 0.0;
    //[self.view addSubview:svgView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeSize:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutViews];
}

- (void)layoutViews
{
    CGPoint c = CGPointMake(self.view.bounds.size.width/2.0f,self.view.bounds.size.height/2.0f);
    for (UIView *v in self.view.subviews)
        v.center=c;
}

- (void)changeSize:(NSTimer*)timer
{
    currentScale=currentScale+0.1;
    if (currentScale>1)
        currentScale = 0.1;
    CGRect f = self.view.bounds;
    f.size.width = f.size.width * currentScale;
    f.size.height = f.size.height * currentScale;
    for (UIView *v in self.view.subviews)
        v.frame=f;
    [self layoutViews];
}

- (void)tappedView:(UITapGestureRecognizer*)tapper
{
    NSArray*svgViews = self.view.subviews;
    for (UIView*v in svgViews)
        v.alpha = 0.0;
    
    NSInteger index = [svgViews indexOfObject:activeView];
    index++;
    if (index>=[svgViews count])
        index = 0;
    
    UIView *nextActive = [svgViews objectAtIndex:index];
    nextActive.alpha = 1.0;
    activeView = nextActive;
}

- (void)twoFingerTappedView:(UITapGestureRecognizer*)tapper
{
    currentImage++;
    if (currentImage>=self.svgFiles.count)
        currentImage = 0;
    [self loadSubviews];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
