//
//  ViewController.m
//  RMMultipleDeleagteDemo
//
//  Created by RaoMeng on 2017/12/21.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "RMMultipleDelegates.h"

@interface ViewController ()<RMMultipleDelegatesDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[RMMultipleDelegates shareHelper]addDelegate:self];
}

- (void)dealloc {
    [[RMMultipleDelegates shareHelper]removeDelegate:self];
}


-(void)multipleDelegatesHelper:(RMMultipleDelegates *)helper sendeData:(id)data {
    
    NSLog(@"first == %@",data);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)senderData:(id)sender {
    
    [[RMMultipleDelegates shareHelper] sendData:@"2222"];
    
}

@end
