//
//  ZYSimpleLabel.h
//  Staring
//
//  Created by Zhenyi Tan on 9/11/13.
//  Copyright (c) 2013 And a Dinosaur. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZYSimpleLabel : NSView <NSMenuDelegate>

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) id target;
@property (assign, nonatomic) SEL action;
@property (assign, nonatomic) SEL rightAction;

- (id) initWithStatusItem:(NSStatusItem *)statusItem;

@end
