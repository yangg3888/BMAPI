//
//  NSTextField+Extension.h
//  QBMAC
//
//  Created by yanggang on 2021/5/26.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTextField (Extension)

/**
 lable显示样式设置
 */
- (void)qb_lableStyle;

/**
 输入框占位符
 */
- (void)qb_setPlaceholder:(NSString *)placeholder color:(NSColor *)color;

/**
 开启垂直居中
 */
- (void)qb_verticallyCenter;

@end

@interface NSTextFieldCell (Extension)
/**
 开启垂直居中
 */
@property (nonatomic, assign) BOOL qb_verticallyCenter;

@end

NS_ASSUME_NONNULL_END
