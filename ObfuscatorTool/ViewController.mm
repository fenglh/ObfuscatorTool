//
//  ViewController.m
//  ObfuscatorTool
//
//  Created by 冯立海 on 2020/1/12.
//  Copyright © 2020 fenglh. All rights reserved.
//

#import "ViewController.h"
#include "Obfuscator.h"

@implementation ViewController

- (void)loadView{
    NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
    self.view = [[NSView alloc] initWithFrame:frame];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
    [button setTarget:self];
    [button setAction:@selector(getFiles:)];
    [button setTitle:@"开始"];
    [self.view addSubview:button];

}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
