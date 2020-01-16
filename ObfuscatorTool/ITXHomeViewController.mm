//
//  ITXHomeViewController.m
//  ObfuscatorTool
//
//  Created by 冯立海 on 2020/1/16.
//  Copyright © 2020 fenglh. All rights reserved.
//

#import "ITXHomeViewController.h"
#include "Obfuscator.h"
#import <Objc/runtime.h>


static ITXHomeViewController *selfClass =nil;

@interface ITXHomeViewController ()<NSTableViewDelegate, NSTableViewDataSource>
@property (unsafe_unretained) IBOutlet NSTextView *logTextView;
@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ITXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selfClass = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;//行高亮的风格
    self.tableView.focusRingType = NSFocusRingTypeNone;//tableview获得焦点时的风格
    self.tableView.usesAlternatingRowBackgroundColors = YES;

}
- (IBAction)selectFiles:(id)sender {
    [self getFiles:sender];
}

- (IBAction)beginAction:(id)sender {
    //执行多线程
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self appendLogToTextView:@"开始进行混淆..."];
        [weakSelf startObfuscate:self.dataArray];
        [self appendLogToTextView:@"混淆完成"];
    });
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.dataArray.count;
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    
    NSString *strIdt = @"123";
     NSTableCellView *cell = [tableView makeViewWithIdentifier:strIdt owner:self];
    if (!cell) {
        cell = [[NSTableCellView alloc]init];
        cell.identifier = strIdt;
    }
    
    cell.wantsLayer = YES;
    cell.textField.textColor = [NSColor blackColor];
    cell.textField.stringValue = [[self.dataArray objectAtIndex:row] lastPathComponent];
    return cell;
}


#pragma mark - 私有方法

- (void)appendLogToTextView :( NSString*)text
{
    __weak typeof(self ) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAttributedString* attr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",text]];
        [[weakSelf.logTextView textStorage] appendAttributedString:attr];
        [weakSelf.logTextView scrollRangeToVisible:NSMakeRange([[weakSelf.logTextView string] length], 0)];
    });
}
- (void)getFiles:(NSButton *)btn {
    

    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];//是否能选择文件file
    [panel setCanChooseDirectories:YES];//是否能打开文件夹
    [panel setAllowsMultipleSelection:YES];//是否允许多选file
    NSInteger finded = [panel runModal]; //获取panel的响应
    NSMutableArray *files = [NSMutableArray array];
    
    if (finded == NSFileHandlingPanelOKButton) {
        for (NSURL *url in [panel URLs]) {
            [self appendLogToTextView:[NSString stringWithFormat:@"源文件:%@", url.path]];
            [files addObject:url.path];
        }
        self.dataArray = [files mutableCopy];
        [self.tableView reloadData];
    }
}


void log(const char *content ){
    //
    NSString *log = [[NSString alloc] initWithCString:content encoding:NSUTF8StringEncoding];
    [selfClass appendLogToTextView:log];
}


- (void)startObfuscate:(NSArray *)sources {
    
    id swself;
    
    if (sources.count == 0) {
        return;
    }
    NSMutableArray *params = [NSMutableArray array];
    [params addObject:@"ObfuscatorTool"];
    [params addObjectsFromArray:sources];
    
    [params addObject:@"--"];
    [params addObject:@"-isysroot"];
    [params addObject:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"];

    int argc = (int)[params count];
    

     
     const char *argv[10]={0};
     int index=0;
     for (NSString *str in params) {
         const char *cString = [str cStringUsingEncoding:NSUTF8StringEncoding];
         argv[index]=cString;
         index++;
     }
    

    
    Obfuscator obfuscator;
    obfuscator.logCallback =log ;
    obfuscator.start(argc, argv);
    
    
}




#pragma mark - getters and setters

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
