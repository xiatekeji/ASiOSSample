#import <UIKit/UIKit.h>

/**
 * @brief 带侧栏的布局。
 *
 * @details // TODO 增加详细说明。
 */
@interface ASSidebarLayout : UIView

/**
 * @brief 主体容器。
 *
 * @discussion 使用者可以向其添加子控件。
 */
@property(nonatomic, readonly) UIView* mainView;
/**
 * @brief 侧栏容器。
 *
 * @discussion 使用者可以向其添加子控件。
 */
@property(nonatomic, readonly) UIView* sidebarView;
/**
 * @brief 遮罩层。
 *
 * @discussion 使用者可以通过改变遮罩层的背景色或向其添加图片来达到遮罩效果。
 */
@property(nonatomic, readonly) UIView* maskView;

/**
 * @brief 侧栏长度（对于横向侧栏来说，就是宽度）。
 *
 * @discussion 如果传入值小于0，会被认为等同于0。当该值被设为0时，实际展现的侧栏长度与整个Layout的长度一致。
 */
@property(nonatomic) CGFloat sidebarLength;

/**
 * @brief 是否接受打开侧栏的手势。
 */
@property(nonatomic) BOOL acceptsSideOpeningGesture;
/**
 * @brief 是否接受关闭侧栏的手势。
 */
@property(nonatomic) BOOL acceptsSideClosingGesture;

/**
 * @brief 设置侧栏是否可见，不采用动画。
 */
- (void)setSideVisible: (BOOL)visible;
/**
 * @brief 设置侧栏是否可见，根据animated参数决定是否采用动画。
 */
- (void)setSideVisible: (BOOL)visible animated: (BOOL)animated;

@end
