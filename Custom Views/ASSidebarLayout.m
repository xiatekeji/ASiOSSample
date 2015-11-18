#import "ASSidebarLayout.h"

#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ASSidebarLayout()<UIScrollViewDelegate> {
	UIView* _mainView;
	
	// 由于_maskView需要改变alpha，在alpha过低（< 0.2）时无法达到阻隔用户操作的目的，
	// 所以引入了外层的_maskContainerView。
	UIView* _maskContainerView;
	UIView* _maskView;
	
	UIScrollView* _sidebarTrackView;
	UIView* _sidebarView;
	
	CGFloat _sidebarOpeningProgress;
	
	NSArray* _swipers;
}

@end

#pragma mark -

@implementation ASSidebarLayout

- (instancetype)initWithFrame: (CGRect)frame {
	self = [super initWithFrame: frame];
	if(self != nil) {
		[self buildViewHierachy];
		[self applyGestureRecognizers];
		
		[
			[RACSignal merge: @[
				[RACObserve(self, acceptsSideOpeningGesture) skip: 1],
				[RACObserve(self, acceptsSideClosingGesture) skip: 1]
			]]
			subscribeNext: ^(id x) {
				[self updateEnablingStateForSwipers];
			}
		];
	}
	
	return self;
}

#pragma mark Layout

- (void)buildViewHierachy {
	UIView* mainView = [[UIView alloc] init];
	[super addSubview: mainView];
	[mainView mas_makeConstraints: ^(MASConstraintMaker* make) {
		make.edges.equalTo(self);
	}];
	_mainView = mainView;
	
	UIView* maskContainerView = [[UIView alloc] init];
	[maskContainerView setHidden: TRUE];
	[super addSubview: maskContainerView];
	[maskContainerView mas_makeConstraints: ^(MASConstraintMaker* make) {
		make.edges.equalTo(self);
	}];
	_maskContainerView = maskContainerView;
	
	UIView* maskView = [[UIView alloc] init];
	[maskView setAlpha: 0];
	[maskContainerView addSubview: maskView];
	[maskView mas_makeConstraints: ^(MASConstraintMaker* make) {
		make.edges.equalTo(maskContainerView);
	}];
	_maskView = maskView;
	
	UIScrollView* sidebarTrackView = [[UIScrollView alloc] init];
	[sidebarTrackView setBounces: FALSE];
	[sidebarTrackView setDelegate: self];
	[sidebarTrackView setHidden: TRUE];
	[sidebarTrackView setPagingEnabled: TRUE];
	[sidebarTrackView setShowsHorizontalScrollIndicator: FALSE];
	[sidebarTrackView setShowsVerticalScrollIndicator: FALSE];
	[super addSubview: sidebarTrackView];
	_sidebarTrackView = sidebarTrackView;
	
	UIView* sidebarView = [[UIView alloc] init];
	[sidebarTrackView addSubview: sidebarView];
	_sidebarView = sidebarView;
}

- (void)applyGestureRecognizers {
	UITapGestureRecognizer* tapper = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)];
	[_maskContainerView addGestureRecognizer: tapper];
	
	NSMutableArray* swipers = [[NSMutableArray alloc] init];
	for(NSNumber* directionNumber in @[
		@(UISwipeGestureRecognizerDirectionLeft),
		@(UISwipeGestureRecognizerDirectionRight)
	]) {
		UISwipeGestureRecognizerDirection direction = [directionNumber integerValue];
		
		UISwipeGestureRecognizer* swiper = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipe:)];
		[swiper setDirection: direction];
		[swiper setEnabled: FALSE];
		[self addGestureRecognizer: swiper];
		
		[swipers addObject: swiper];
	}
	_swipers = swipers;
}

#pragma mark Public

@synthesize mainView = _mainView;

@synthesize sidebarView = _sidebarView;

@synthesize maskView = _maskView;

@synthesize sidebarLength = _sidebarLength;

- (void)setSidebarLength: (CGFloat)sidebarLength {
	if(sidebarLength < 0) {
		sidebarLength = 0;
	}
	
	if(_sidebarLength == sidebarLength) {
		return;
	}
	
	_sidebarLength = sidebarLength;
	
	[self setNeedsLayout];
}

- (void)setSideVisible: (BOOL)visible {
	[self setSideVisible: visible animated: FALSE];
}

- (void)setSideVisible: (BOOL)visible animated: (BOOL)animated {
	// 如果请求状态和当前状态完全吻合，无视请求且不触发动画。
	if(visible ? _sidebarOpeningProgress == 1.0 : _sidebarOpeningProgress == 0.0) {
		return;
	}
	
	CGFloat offsetX = visible ? 0 : [self actualSideLength];
	[_sidebarTrackView setContentOffset: CGPointMake(offsetX, 0) animated: animated];
	
	// 控件状态处理由_sidebarTrackView的delegate回调完成。
}

#pragma mark Private

- (CGFloat)actualSideLength {
	CGRect bounds = [super bounds];
	CGFloat width = CGRectGetWidth(bounds);
	
	CGFloat actualSideLength = _sidebarLength == 0 ? width : _sidebarLength;
	
	return actualSideLength;
}

- (void)handleTap: (UITapGestureRecognizer*)tapper {
	UIView* target = [tapper view];
	
	if(target == _maskContainerView) {
		[self setSideVisible: FALSE animated: TRUE];
		
		return;
	}
}

- (UISwipeGestureRecognizerDirection)directionForSideOpening {
	return UISwipeGestureRecognizerDirectionRight;
}

- (UISwipeGestureRecognizerDirection)directionForSideClosing {
	return UISwipeGestureRecognizerDirectionLeft;
}

- (void)handleSwipe: (UISwipeGestureRecognizer*)swiper {
	UIView* target = [swiper view];
	
	if(target == self) {
		UIGestureRecognizerState state = [swiper state];
		
		if(state == UIGestureRecognizerStateEnded) {
			UISwipeGestureRecognizerDirection direction = [swiper direction];
			
			UISwipeGestureRecognizerDirection openingDirection = [self directionForSideOpening];
			if(direction == openingDirection) {
				[self setSideVisible: TRUE animated: TRUE];
				
				return;
			}
			
			UISwipeGestureRecognizerDirection closingDirection = [self directionForSideClosing];
			if(direction == closingDirection) {
				[self setSideVisible: FALSE animated: TRUE];
				
				return;
			}
		}
		
		return;
	}
}

- (void)updateEnablingStateForSwipers {
	UISwipeGestureRecognizerDirection openingDirection = [self directionForSideOpening];
	UISwipeGestureRecognizerDirection closingDirection = [self directionForSideClosing];
	
	for(UISwipeGestureRecognizer* swiper in _swipers) {
		UISwipeGestureRecognizerDirection direction = [swiper direction];
		if(direction == openingDirection) {
			[swiper setEnabled: _acceptsSideOpeningGesture];
		}
		else if(direction == closingDirection) {
			[swiper setEnabled: _acceptsSideClosingGesture];
		}
		else {
			[swiper setEnabled: FALSE];
		}
	}
}

#pragma mark Override

- (void)layoutSubviews {
	CGFloat progress = _sidebarOpeningProgress;
	assert(progress >= 0 && progress <= 1);
	
	CGRect bounds = [super bounds];
	CGFloat height = CGRectGetHeight(bounds);
	
	CGFloat actualSideLength = [self actualSideLength];
	
	[_sidebarTrackView setFrame: CGRectMake(0, 0, actualSideLength, height)];
	[_sidebarTrackView setContentSize: CGSizeMake(actualSideLength * 2, height)];
	[_sidebarTrackView setContentOffset: CGPointMake(actualSideLength * (1 - progress), 0)];
	
	[_sidebarView setFrame: CGRectMake(0, 0, actualSideLength, height)];
	
	[super layoutSubviews];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll: (UIScrollView*)scrollView {
	if(scrollView == _sidebarTrackView) {
		CGFloat actualSideLength = [self actualSideLength];
		
		CGPoint offset = [scrollView contentOffset];
		CGFloat offsetX = offset.x;
		
		CGFloat progress = MAX(MIN(1 - offsetX / actualSideLength, 1), 0);
		_sidebarOpeningProgress = progress;
		
		[_maskView setAlpha: progress];
		
		BOOL closed = (progress == 0);
		[_maskContainerView setHidden: closed];
		[_sidebarTrackView setHidden: closed];
		
		return;
	}
}

@end
