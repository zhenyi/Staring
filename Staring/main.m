//
//  main.m
//  Staring
//
//  Created by Zhenyi Tan on 9/11/13.
//  Copyright (c) 2013 And a Dinosaur. All rights reserved.
//

#import "ZYAppDelegate.h"


int main (int argc, const char * argv[]) {
    NSApplication *application = [NSApplication sharedApplication];
    ZYAppDelegate *appDelegate = [[ZYAppDelegate alloc] init];
    application.delegate = appDelegate;
    [application run];

    return EXIT_SUCCESS;
}
