//
//  ThreeViewController.m
//  RMMultipleDeleagteDemo
//
//  Created by RaoMeng on 2017/12/21.
//  Copyright © 2017年 TianyingJiuzhou Network Technology Co. Ltd. All rights reserved.
//

#import "ThreeViewController.h"
#import "RMMultipleDelegates.h"

@interface ThreeViewController ()<RMMultipleDelegatesDelegate>


@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[RMMultipleDelegates shareHelper]addDelegate:self];
}

- (void)dealloc {
    
    [[RMMultipleDelegates shareHelper]removeDelegate:self];
}

-(void)multipleDelegatesHelper:(RMMultipleDelegates *)helper sendeData:(id)data {
     NSLog(@"three  ==  %@",data);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
