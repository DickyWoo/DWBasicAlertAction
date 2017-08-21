//
//  ViewController.m
//  DWBasicAlertAction
//
//  Created by DickyWoo on 2017/8/21.
//  Copyright © 2017年 Dicky. All rights reserved.
//

#import "ViewController.h"
#import "DWBasicAlertAction.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)alertButtonClick:(id)sender {
    [DWBasicAlertAction showAlertWithTitle:@"Alert" message:@"DWBasicAlertAction" cancelButtonTitle:@"cancel" otherButtonTitles:@[@"item1",@"item2",@"item3",@"item4",@"item5",@"item6"]  chooseBlock:^(NSInteger buttonIdx) {
        NSLog(@"click buttonIdx:%ld",buttonIdx);
    }];
}

- (IBAction)actionSheetButtonClick:(id)sender {
    [DWBasicAlertAction showActionSheetWithTitle:@"ActionSheet" message:@"DWBasicAlertAction" cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destrutive" otherButtonTitles:@[@"item1",@"item2",@"item3",@"item4",@"item5",@"item6"] chooseBlock:^(NSInteger buttonIdx) {
        NSLog(@"click buttonIdx:%ld",buttonIdx);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
