//
//  ZYAppDelegate.m
//  Staring
//
//  Created by Zhenyi Tan on 9/11/13.
//  Copyright (c) 2013 And a Dinosaur. All rights reserved.
//

#import "ZYAppDelegate.h"
#import "ZYSimpleLabel.h"


@interface ZYAppDelegate ()

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) NSMenu *menu;
@property (strong, nonatomic) ZYSimpleLabel *label;

@property (assign, nonatomic) BOOL isStaring;
@property (strong, nonatomic) NSTask *task;

@end

@implementation ZYAppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self createStatusItem];
    [self createMenu];
    [self createLabel];

    self.isStaring = NO;
    self.statusItem.view = self.label;
    self.menu.delegate = self.label;
    [self startStaring];
}

#pragma mark - Create views

#define STATUS_ITEM_WIDTH 36

- (void) createStatusItem {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:STATUS_ITEM_WIDTH];
}

- (void) createMenu {
    self.menu = [[NSMenu alloc] initWithTitle:@"Staring"];
    [self.menu addItemWithTitle:@"" action:nil keyEquivalent:@""];
    [self.menu addItemWithTitle:@"" action:nil keyEquivalent:@""];
    [self.menu addItemWithTitle:@"" action:nil keyEquivalent:@""];
    [self.menu addItem:[NSMenuItem separatorItem]];
    [self.menu addItemWithTitle:@"Quit Staring" action:@selector(quit) keyEquivalent:@""];
}

- (void) createLabel {
    self.label = [[ZYSimpleLabel alloc] initWithStatusItem:self.statusItem];
    self.label.title = @"";
    self.label.target = self;
    self.label.action = @selector(leftClicked);
    self.label.rightAction = @selector(rightClicked);
}

#pragma mark - Mouse actions

- (void) leftClicked {
    if (self.isStaring) {
        [self stopStaring];
    } else {
        [self startStaring];
    }
}

- (void) rightClicked {
    [self.statusItem popUpStatusItemMenu:self.menu];
}

#pragma mark - Misc

- (void) startStaring {
    self.isStaring = YES;
    self.task = [NSTask launchedTaskWithLaunchPath:@"/usr/bin/caffeinate" arguments:@[@"-ut 315360000"]];
    self.label.title = @"\u0ca0_\u0ca0";

    NSMenuItem *statusMenuItem = [self.menu itemAtIndex:0];
    NSMenuItem *statusMenuItem2 = [self.menu itemAtIndex:1];
    NSMenuItem *onOffMenuItem = [self.menu itemAtIndex:2];
    statusMenuItem.title = @"I am Staring at You";
    statusMenuItem2.title = @"Your Mac Cannot Sleep";
    onOffMenuItem.title = @"Stop Staring";
    onOffMenuItem.action = @selector(stopStaring);
}

- (void) stopStaring {
    self.isStaring = NO;
    [self.task terminate];
    self.label.title = @"-_-";

    NSMenuItem *statusMenuItem = [self.menu itemAtIndex:0];
    NSMenuItem *statusMenuItem2 = [self.menu itemAtIndex:1];
    NSMenuItem *onOffMenuItem = [self.menu itemAtIndex:2];
    statusMenuItem.title = @"I am Not Staring at You";
    statusMenuItem2.title = @"Your Mac Can Now Sleep";
    onOffMenuItem.title = @"Start Staring";
    onOffMenuItem.action = @selector(startStaring);
}

- (void) quit {
    if (self.isStaring) [self stopStaring];
    [NSApp terminate:nil];
}

@end
