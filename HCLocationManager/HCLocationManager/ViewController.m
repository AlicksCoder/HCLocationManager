//
//  ViewController.m
//  HCLocationManager
//
//  Created by ZHC on 16/7/2.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "ViewController.h"
#import "HCLocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HCLocationManager *locMgr = [HCLocationManager manager];
    [locMgr startLoactionWithComplete:^(NSString *city, CLPlacemark *placemark, CLLocation *currentLocation, NSError *error) {
        if (error) {
            // HCLog(@"定位失败，%@",error);
            return ;
        }
        
        NSLog(@"city --- %@------%@",city,placemark.name);
        
    }
    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
