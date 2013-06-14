//
//  ViewController.h
//  SVGTest
//
//  Created by Aleksander Slater on 14/06/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class CKSVGView;
@class SVGKFastImageView;
@interface ViewController : UIViewController
//@property(nonatomic,retain) CKSVGView *svgView;
@property(nonatomic,retain) SVGKFastImageView *fimgView;
@property(nonatomic,readwrite) CGFloat currentScale;
@property(nonatomic,readwrite) NSInteger currentImage;
@property(nonatomic,assign) UIView *activeView;
@end
