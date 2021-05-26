//
//  NSTextField+Extension.m
//  QBMAC
//
//  Created by yanggang on 2021/5/26.
//

#import "NSTextField+Extension.h"
#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSTextField (Extension)

- (void)qb_lableStyle {
    self.enabled = NO;//不可编辑
    self.bordered = NO;//无边框
    self.drawsBackground = NO;//无背景
    self.focusRingType = NSFocusRingTypeNone;//取消焦点
}

- (void)qb_setPlaceholder:(NSString *)placeholder color:(NSColor *)color {
    if (placeholder == nil) {
        return;
    }
    if(color == nil) {
        color = NSColor.lightGrayColor;
    }
    NSDictionary *attrs = @{NSFontAttributeName:self.font,
                            NSForegroundColorAttributeName:color };
    NSAttributedString *string_att = [[NSAttributedString alloc] initWithString:placeholder attributes:attrs];
    [self setPlaceholderAttributedString:string_att];
}

- (void)qb_verticallyCenter {
    [(NSTextFieldCell *)self.cell setQb_verticallyCenter:YES];
}

@end

@implementation NSTextFieldCell (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(drawingRectForBounds:) withMethod:@selector(qb_drawingRectForBounds:)];
    });
}

- (NSRect)qb_drawingRectForBounds:(NSRect)rect {
    if (!self.qb_verticallyCenter) {
        return [self qb_drawingRectForBounds:rect];
    }
    NSRect newRect = [self qb_drawingRectForBounds:rect];
    NSSize textSize = [self cellSizeForBounds:rect];
    
    CGFloat heightDelta = newRect.size.height - textSize.height;
    if (heightDelta > 0) {
        newRect.size.height = textSize.height;
        newRect.origin.y += heightDelta/2.0;
    }
    return newRect;
}

- (void)setQb_verticallyCenter:(BOOL)qb_verticallyCenter {
    objc_setAssociatedObject(self, @selector(qb_verticallyCenter), [NSNumber numberWithBool:qb_verticallyCenter], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)qb_verticallyCenter {
    return [objc_getAssociatedObject(self, @selector(qb_verticallyCenter)) boolValue];
}

@end
