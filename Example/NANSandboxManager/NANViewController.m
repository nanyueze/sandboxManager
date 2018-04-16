//
//  NANViewController.m
//  NANSandboxManager
//
//  Created by nanyueze on 04/16/2018.
//  Copyright (c) 2018 nanyueze. All rights reserved.
//

#import "NANViewController.h"
#import <NANSandboxManager/NANSandboxViewController.h>

@interface NANViewController ()

@end

@implementation NANViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIButton *fileSystemBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 40)];
    [fileSystemBtn setTitle:@"浏览沙盒" forState:UIControlStateNormal];
    [fileSystemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fileSystemBtn addTarget:self action:@selector(scanSandbox) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fileSystemBtn];
}

- (void)scanSandbox
{
    [NANSandboxViewController presentFSViewControllerFrom:self filePath:nil];
}

@end
