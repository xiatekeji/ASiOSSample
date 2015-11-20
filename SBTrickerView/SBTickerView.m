//
//  --------------------------------------------
//  Copyright (C) 2011 by Simon Blommegård
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  --------------------------------------------
//
//  SBTickerView.m
//  SBTickerView
//
//  Created by Simon Blommegård on 2011-12-10.
//  Copyright 2011 Simon Blommegård. All rights reserved.
//
// todo:这个控件进行了修改，满足横屏的需要
#import "SBTickerView.h"
#import "SBDoubleSidedLayer.h"
#import "UIView+SBExtras.h"
#import "SBGradientOverlayLayer.h"


@interface SBTickerView ()
@property (nonatomic, strong) SBGradientOverlayLayer *topFaceLayer;
@property (nonatomic, strong) SBGradientOverlayLayer *bottomFaceLayer;
@property (nonatomic, strong) SBDoubleSidedLayer *tickLayer;
@property (nonatomic, strong) CALayer *flipLayer;
@property (nonatomic,strong) CAShapeLayer *frontMaskLayer;
@property (nonatomic,strong) CAShapeLayer *backMaskLayer;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

- (void)_setup;
- (void)_initializeTick:(SBTickerViewTickDirection)direction;
- (void)_finalizeTick:(void (^)(void))completion;
- (void)_pan:(UIPanGestureRecognizer *)gestureRecognizer;
@end

@implementation SBTickerView {
    struct {
        unsigned int ticking:1;
        unsigned int panning:1;
    } _flags;
    
    SBTickerViewTickDirection _panningDirection;
    
    CGPoint _initialPanPosition;
    CGPoint _lastPanPosition;
}

@synthesize topFaceLayer = _topFaceLayer;
@synthesize bottomFaceLayer = _bottomFaceLayer;
@synthesize tickLayer = _tickLayer;
@synthesize flipLayer = _flipLayer;

@synthesize frontView = _frontView;
@synthesize backView = _backView;
@synthesize duration = _duration;

@synthesize panning = _panning;
@synthesize allowedPanDirections = _allowedPanDirections;
@synthesize panGestureRecognizer = _panGestureRecognizer;
@synthesize masks;
@synthesize inFlip;
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) 
        [self _setup];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) 
        [self _setup];
    return self;
}

- (id)init {
    if ((self = [super init]))
        [self _setup];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_frontView setFrame:self.bounds];
    [_backView setFrame:self.bounds];
}

#pragma mark - Properties

- (void)setFrontView:(UIView *)frontView {
  
    
    if (_frontView.superview)
        [_frontView removeFromSuperview];
    _frontView = frontView;
    [self addSubview:frontView];
}

- (void)setPanning:(BOOL)panning {
    if (_panning != panning) {
        _panning = panning;
        
        if (_panning)
            [self addGestureRecognizer:self.panGestureRecognizer];
        else
            [self removeGestureRecognizer:self.panGestureRecognizer];
    }
}

- (UIPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_pan:)];
    }
    
    return _panGestureRecognizer;
}

-(void)setMask:(BOOL)state {
    self.masks = state;
    if(self.masks) {
        [self drawMaskView];
    }
    else {
        self.frontView.layer.mask = nil;
        self.backView.layer.mask = nil;
        [self setNeedsDisplay];
    }

}

// 绘制遮罩层
-(void)drawMaskView {
  

    
} 


#pragma mark - Private

- (void)_setup {
    //tickIndex = 0;
    _duration = 0.5;
    _frontMaskLayer = [[CAShapeLayer alloc] init];
    _backMaskLayer = [[CAShapeLayer alloc] init];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)_initializeTick:(SBTickerViewTickDirection)direction {
//    if ([self.delegate respondsToSelector:@selector(tickerViewDidStartTurnPage)])
//    {
//        [self.delegate ti];
//    }
    
    [self setFlipLayer:[CALayer layer]];
    [_flipLayer setFrame:self.layer.bounds];
    NSLog(@"%f",self.frame.size.width);
    NSLog(@"%f",self.frame.size.height);
    NSLog(@"%f",_flipLayer.frame.size.width);
    NSLog(@"%f",_flipLayer.frame.size.height);
    NSLog(@"%f",floorf(_flipLayer.frame.size.height));
    NSLog(@"%f",floorf(_flipLayer.frame.size.width/2));
    NSLog(@"%f",_flipLayer.frame.origin.x);
    NSLog(@"%f",_flipLayer.frame.origin.y);
    //NSLog(@"%f",self.layer.bounds.size.width);
    //NSLog(@"%f",self.layer.bounds.size.height);
    //_frontView.clipsToBounds = YES;
   // _backView.clipsToBounds = YES;
    
    if(self.masks)
        [self drawMaskView];
    
    CATransform3D perspective = CATransform3DIdentity;
    // 设置Z轴动画
    float zDistanse = 600;
    perspective.m34 = 1. / -zDistanse;
    [_flipLayer setSublayerTransform:perspective];
    
    [self.layer addSublayer:_flipLayer];
    
    UIImage *frontImage = [_frontView image];
    UIImage *backImage = [_backView image];
    
    NSInteger *intDirection;
    if (direction == SBTickerViewTickDirectionDown) {
        intDirection = 0;
    }else{
        intDirection = 1;
    }
    
    // Face layers
    // Top
    [self setTopFaceLayer:[[SBGradientOverlayLayer alloc] initWithStyle:SBGradientOverlayLayerTypeFace
                                                                segment:SBGradientOverlayLayerSegmentTop]];
    // Bottom
    [self setBottomFaceLayer:[[SBGradientOverlayLayer alloc] initWithStyle:SBGradientOverlayLayerTypeFace
                                                                   segment:SBGradientOverlayLayerSegmentBottom]];
    // Tick layer
    [self setTickLayer:[[SBDoubleSidedLayer alloc] init]];
    [_tickLayer setFrame:CGRectMake(floorf(_flipLayer.frame.size.width/4),-floorf(_flipLayer.frame.size.height/2), floorf(_flipLayer.frame.size.width/2), _flipLayer.frame.size.height)];
    [_topFaceLayer setFrame:CGRectMake(_flipLayer.frame.origin.x, _flipLayer.frame.origin.y, floorf(_flipLayer.frame.size.width/2),_flipLayer.frame.size.height )];
    [_bottomFaceLayer setFrame:CGRectMake(floorf(_flipLayer.frame.origin.x + _flipLayer.frame.size.width/2), _flipLayer.frame.origin.y, floorf(_flipLayer.frame.size.width/2), _flipLayer.frame.size.height)];
    [_tickLayer setAnchorPoint:CGPointMake(1., 0.)];

    [_tickLayer setZPosition:1.]; // Above the other ones
    [_tickLayer setTransform:CATransform3DIdentity];
    [_tickLayer setFrontLayer:[[SBGradientOverlayLayer alloc] initWithStyle:SBGradientOverlayLayerTypeTick
                                                                    segment:SBGradientOverlayLayerSegmentTop]];
    
    [_tickLayer setBackLayer:[[SBGradientOverlayLayer alloc] initWithStyle:SBGradientOverlayLayerTypeTick
                                                                   segment:SBGradientOverlayLayerSegmentBottom]:intDirection];
    // 白色图片，用来遮盖，这里用220x220的图片拉伸到880x880
    //UIImage *maskImage = [appDelegate scale:[UIImage imageNamed:@"white_220.jpg"] toSize:CGSizeMake(880, 880)];
   // UIImage *maskImage = [UIImage imageNamed:@"Background_640x640.png"];
    self.inFlip = YES;
    UIImage *maskImage = nil;
//    CALayer* boxLayer = [CALayer layer];
//    boxLayer.frame           = CGRectMake(0, 0, 100, 100);
//    boxLayer.backgroundColor =  (__bridge CGColorRef)([UIColor clearColor]);
//    boxLayer.position = CGPointMake(110, 10);
//    boxLayer.anchorPoint = CGPointMake(0,0);
    
    // 往右
    //NSLog(@"%d",self.tag);
    if (direction == SBTickerViewTickDirectionDown) {
        if (self.tag == 0) {
            // 考虑做成遮罩
             [_topFaceLayer setContents:(__bridge id)backImage.CGImage];
        //    [_topFaceLayer removeFromSuperlayer]; _topFaceLayer = nil;
            //[_topFaceLayer setContents:[[UIImage alloc]init]];
        }else{
            [_topFaceLayer setContents:(__bridge id)backImage.CGImage];
        }
        [_bottomFaceLayer setContents:(__bridge id)frontImage.CGImage];
        // 这里设置的是当前页左边的照片
        [_tickLayer.frontLayer setContents:(__bridge id)frontImage.CGImage];
        // 这里设置的是前一页右边的照片
        [_tickLayer.backLayer setContents:(__bridge id)backImage.CGImage];
        // 目前去掉拉阴影，效果不好
        //[_topFaceLayer setGradientOpacity:1.];
        //[_topFaceLayer setGradientOpacity:1.];
    }
    
    // 往左
    else if (direction == SBTickerViewTickDirectionUp) {
    
        [_topFaceLayer setContents:(__bridge id)frontImage.CGImage];
        // 这里设置的是后一页左边的照片
        [_tickLayer.frontLayer setContents:(__bridge id)backImage.CGImage];
        // 这里设置的是当前页右边的照片
        [_tickLayer.backLayer setContents:(__bridge id)frontImage.CGImage];
        // 目前去掉拉阴影，效果不好
        //[_topFaceLayer setGradientOpacity:1.];
        //[_bottomFaceLayer setGradientOpacity:1.];
        _tickLayer.transform = CATransform3DMakeRotation(3.1415925, 0., 1., 0.);
    }
    // Add layers
    [_flipLayer addSublayer:_topFaceLayer];
    [_flipLayer addSublayer:_bottomFaceLayer];
    [_flipLayer addSublayer:_tickLayer];
}

- (void)_finalizeTick:(void (^)(void))completion {
    [self setFrontView:self.backView];
    if (_frontView.superview)
        [_frontView removeFromSuperview];
    [self addSubview:_backView];
    [self setBackView:self.backView];
    
    if (completion)
        completion();
    
    _flags.ticking = NO;
    
    if ([self.delegate respondsToSelector:@selector(tickerViewDidFinishTurnPage)])
    {
        [self.delegate tickerViewDidFinishTurnPage];
    }
}



- (void)_pan:(UIPanGestureRecognizer *)gestureRecognizer {
    

    
    if (self.allowedPanDirections == SBTickerViewAllowedPanDirectionNone)
        return;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        _initialPanPosition = [gestureRecognizer locationInView:self];
    
    _lastPanPosition = [gestureRecognizer locationInView:self];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    // Start
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged && !_flags.panning) {
   
        // Down 往右翻页(direction = 0)
        if (self.allowedPanDirections & SBTickerViewAllowedPanDirectionDown && _initialPanPosition.x < _lastPanPosition.x) {

            _panningDirection = SBTickerViewTickDirectionDown;
            _flags.panning = YES;
            /*
            NSLog(@"Start down");
            _panningDirection = SBTickerViewTickDirectionDown;
            _flags.panning = YES;
            // 上次翻页还未完成，先记录下操作
            if (_flags.ticking) {
                [appDelegate.panArray addObject:@"-2"];
                NSLog(@"appDelegate.panArray: %@", appDelegate.panArray);
                return;
            }
            if ([appDelegate.panArray count] == 0) {
                [appDelegate.panArray addObject:@"-2"];
            }
            //压缩duration时间
            _duration = 0.75/[appDelegate.panArray count];
            for (NSInteger *page = tickIndex; page < [appDelegate.panArray count]; page++) {
                self.tag = self.tag + [[appDelegate.panArray objectAtIndex:page] intValue];
                [dic setValue:[NSString stringWithFormat:@"%d",self.tag] forKey:@"tag"];
                [dic setObject:@"0" forKey:@"direction"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"setBackViewNotification" object:nil userInfo:dic];
                if (appDelegate.canTickFlg) {
                    [self tick:0 animated:YES completion:^{
                    }];
                    tickIndex = page;
                }
            }
            */
            [self.delegate tickerViewDidStartTurnPage:_panningDirection];
            if (_flags.ticking) {
                return;
            }
            self.tag -=1;
            if (self.tag < 0) {
                self.tag = self.tag+1;
                return;
            }
        
        
            

        }
        // Up 往左翻页(direction = 1)
        if (self.allowedPanDirections & SBTickerViewAllowedPanDirectionUp && _initialPanPosition.x > _lastPanPosition.x) {
            _panningDirection = SBTickerViewTickDirectionUp;
            _flags.panning = YES;
            /*
            appDelegate.canTickFlg = NO;
            NSLog(@"Start up");
            _panningDirection = SBTickerViewTickDirectionUp;
            _flags.panning = YES;
            // 这里设置判断防止上一次翻页没完成就触发下一次
            if (_flags.ticking) {
                [appDelegate.panArray addObject:@"2"];
                NSLog(@"appDelegate.panArray: %@", appDelegate.panArray);
                return;
            }
            if ([appDelegate.panArray count] == 0) {
                [appDelegate.panArray addObject:@"2"];
            }
            //压缩duration时间
            _duration = 0.75/([appDelegate.panArray count]-(int)tickIndex);
            for (NSInteger *page = tickIndex; page < [appDelegate.panArray count]; page++) {
                self.tag = self.tag + [[appDelegate.panArray objectAtIndex:page] intValue];
                [dic setValue:[NSString stringWithFormat:@"%d",self.tag] forKey:@"tag"];
                [dic setObject:@"0" forKey:@"direction"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"setBackViewNotification" object:nil userInfo:dic];
                if (appDelegate.canTickFlg) {
                    [self tick:0 animated:YES completion:^{
                    }];
                    tickIndex = page;
                }
                
            }
             */
            [self.delegate tickerViewDidStartTurnPage:_panningDirection];
            if (_flags.ticking) {
                return;
            }
            self.tag +=1;
          

       
        
        }
        
        return;
    }
    
    // Pan
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged && _flags.panning) {
        // Nop
        if (!(_panningDirection == SBTickerViewTickDirectionDown && _initialPanPosition.y >= _lastPanPosition.y) &&
            !(_panningDirection == SBTickerViewTickDirectionUp && _initialPanPosition.y <= _lastPanPosition.y)) {
 
            NSLog(@"Pan!");
        }
    }
    
    // End
    if ((gestureRecognizer.state == UIGestureRecognizerStateCancelled || gestureRecognizer.state == UIGestureRecognizerStateEnded)
        && _flags.panning) {
 
        NSLog(@"Pan End");
        _flags.panning = NO;
        /*
        _flags.panning = NO;
        if(self.allowedPanDirections & SBTickerViewAllowedPanDirectionDown && _initialPanPosition.x < _lastPanPosition.x){
            NSLog(@"down!!!!!!!!!!!!!!!!!!");
            [appDelegate.panArray addObject:@"-2"];
            NSLog(@"appDelegate.panArray: %@", appDelegate.panArray);
            if (!_flags.ticking) {
                //压缩duration时间
                _duration = 0.75/([appDelegate.panArray count]-(int)tickIndex);
                for (NSInteger page = tickIndex; page < [appDelegate.panArray count]; page++) {
                    self.tag = self.tag + [[appDelegate.panArray objectAtIndex:page] intValue];
                    [dic setValue:[NSString stringWithFormat:@"%d",self.tag] forKey:@"tag"];
                    [dic setObject:@"0" forKey:@"direction"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"setBackViewNotification" object:nil userInfo:dic];
                    if (appDelegate.canTickFlg) {
                        [self tick:0 animated:YES completion:^{
                        }];
                    }
                    tickIndex = page;
                }
            }
        }else if (self.allowedPanDirections & SBTickerViewAllowedPanDirectionUp && _initialPanPosition.x > _lastPanPosition.x){
            NSLog(@"up!!!!!!!!!!!!!!!!!!");
            [appDelegate.panArray addObject:@"2"];
            NSLog(@"appDelegate.panArray: %@", appDelegate.panArray);
            if (!_flags.ticking) {
                //压缩duration时间
                _duration = 0.75/([appDelegate.panArray count]-(int)tickIndex);
                for (NSInteger page = tickIndex; page < [appDelegate.panArray count]; page++) {
                    self.tag = self.tag + [[appDelegate.panArray objectAtIndex:page] intValue];
                    [dic setValue:[NSString stringWithFormat:@"%d",self.tag] forKey:@"tag"];
                    [dic setObject:@"1" forKey:@"direction"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"setBackViewNotification" object:nil userInfo:dic];
                    if (appDelegate.canTickFlg) {
                        [self tick:1 animated:YES completion:^{
                        }];
                    }
                    tickIndex = page;
                }
            }
        }
        */
    }
}

- (CGPoint)_invalidPanPosition {
    return CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
}

#pragma mark - Public

- (void)tick:(SBTickerViewTickDirection)direction animated:(BOOL)animated completion:(void (^)(void))completion {
    


    if (_flags.ticking || !_frontView || !_backView){
        return;
    }else{
        _flags.ticking = YES;
        if (!animated) {
            [self _finalizeTick:completion];
            return;
        }

        [self _initializeTick:direction];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, .01 * NSEC_PER_SEC); // WTF!
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [CATransaction begin];
        [CATransaction setAnimationDuration:_duration];
        
        [CATransaction setCompletionBlock:^{
            self.inFlip = NO;
            [_flipLayer removeFromSuperlayer], _flipLayer = nil;
            [_topFaceLayer removeFromSuperlayer], _topFaceLayer = nil;
            [_bottomFaceLayer removeFromSuperlayer], _bottomFaceLayer = nil;
            if(_tickLayer != nil) {
              [_tickLayer removeFromSuperlayer], _tickLayer = nil;
            }
            [self _finalizeTick:completion];
        }];
        
        CGFloat angle = (M_PI) * (1-direction);
        if (direction == 0) {
            _tickLayer.transform = CATransform3DMakeRotation(3.1415925, 0., 1., 0.);
        }else{
            _tickLayer.transform = CATransform3DMakeRotation(angle, 0., 1., 0.);
        }
        _topFaceLayer.gradientOpacity = direction;
        _bottomFaceLayer.gradientOpacity = 1. - direction;
        
        ((SBGradientOverlayLayer*)_tickLayer.frontLayer).gradientOpacity = 1. - direction;
        ((SBGradientOverlayLayer*)_tickLayer.backLayer).gradientOpacity = direction;
        
        [CATransaction commit];
        });
    }
}

@end
