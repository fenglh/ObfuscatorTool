//
//  AppDelegate.m
//  ObfuscatorTool
//
//  Created by 冯立海 on 2020/1/12.
//  Copyright © 2020 fenglh. All rights reserved.
//

#import "AppDelegate.h"
#import "ITXHomeViewController.h"


@interface AppDelegate ()
@property (nonatomic, strong) NSWindow *window;
@property (nonatomic, strong) NSViewController *homeVC;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    //窗口 关闭，缩小，放大等功能，根据需求自行组合
    NSUInteger style =  NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
       float w = [[NSScreen mainScreen] frame].size.width/2;
       float h = [[NSScreen mainScreen] frame].size.height/2;
       self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, w, h) styleMask:style backing:NSBackingStoreBuffered defer:YES];
       self.window.title = @"hello";
       [self.window makeKeyAndOrderFront:nil];
       [self.window center];
       
       self.homeVC = [[ITXHomeViewController alloc] init];
       [self.window setContentViewController:self.homeVC];
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
