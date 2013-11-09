//
//  ZYSimpleLabel.m
//  Staring
//
//  Created by Zhenyi Tan on 9/11/13.
//  Copyright (c) 2013 And a Dinosaur. All rights reserved.
//

#import "ZYSimpleLabel.h"


@interface ZYSimpleLabel ()

@property (assign, nonatomic) NSStatusItem *statusItem;
@property (assign, nonatomic) BOOL isHighlighted;

@end

@implementation ZYSimpleLabel

- (id) initWithStatusItem:(NSStatusItem *)statusItem {
    if (self = [super initWithFrame:NSZeroRect]) {
        self.statusItem = statusItem;
    }
    return self;
}

#pragma mark - Properties

- (void) setTitle:(NSString *)title {
    _title = title;
    [self setNeedsDisplay:YES];
}

- (void) setIsHighlighted:(BOOL)isHighlighted {
    _isHighlighted = isHighlighted;
    [self setNeedsDisplay:YES];
}

#pragma mark - Mouse event handlers

- (void) mouseDown:(NSEvent *)event {
    self.isHighlighted = YES;
    if ([event modifierFlags] & NSControlKeyMask) {
        [NSApp sendAction:self.rightAction to:self.target from:self];
    } else {
        [NSApp sendAction:self.action to:self.target from:self];
    }
}

- (void) mouseUp:(NSEvent *)event {
    self.isHighlighted = NO;
}

- (void) rightMouseDown:(NSEvent *)event {
    [NSApp sendAction:self.rightAction to:self.target from:self];
}

#pragma mark - NSMenuDelegate methods

- (void) menuWillOpen:(NSMenu *)menu {
    self.isHighlighted = YES;
}

- (void) menuDidClose:(NSMenu *)menu {
    self.isHighlighted = NO;
}

#pragma mark - Low level drawing

#define STATUS_ITEM_FONT_SIZE 14

- (void) drawRect:(NSRect)rect {
    [self.statusItem drawStatusBarBackgroundInRect:self.bounds
                                     withHighlight:self.isHighlighted];

    NSDictionary *textAttributes = nil;
    if (self.isHighlighted) {
        textAttributes = @{NSFontAttributeName: [NSFont systemFontOfSize:STATUS_ITEM_FONT_SIZE],
                           NSForegroundColorAttributeName: [NSColor whiteColor]};
    } else {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = NSMakeSize(0, -1);
        shadow.shadowColor = [NSColor colorWithDeviceWhite:1 alpha:0.25];
        textAttributes = @{NSFontAttributeName: [NSFont systemFontOfSize:STATUS_ITEM_FONT_SIZE],
                           NSForegroundColorAttributeName: [NSColor blackColor],
                           NSShadowAttributeName: shadow};
    }

    NSSize titleSize = [self.title sizeWithAttributes:textAttributes];
    NSRect textRect = self.bounds;
    textRect.origin.x += (textRect.size.width - titleSize.width) / 2;
    textRect.origin.y--;
    textRect.size.width = titleSize.width;

    [self.title drawInRect:textRect
            withAttributes:textAttributes];
}

@end
