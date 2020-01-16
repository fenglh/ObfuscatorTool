//
//  main.m
//  ObfuscatorTool
//
//  Created by 冯立海 on 2020/1/12.
//  Copyright © 2020 fenglh. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
    
    NSApplication *app = [NSApplication sharedApplication];
    id delegate = [[AppDelegate alloc] init];
    app.delegate = delegate;
    return NSApplicationMain(argc, argv);
}
