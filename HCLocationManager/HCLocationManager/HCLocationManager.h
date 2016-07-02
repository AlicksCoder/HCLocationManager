//
//  HCLocationManager.h
//  Traveling
//
//  Created by ZHC on 16/7/2.
//  Copyright © 2016年 ZHC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HCLocationManager : NSObject

/**
 *  locationBack回调
 *
 */
typedef void (^locationBack)(NSString *city, CLPlacemark *placemark, CLLocation *currentLocation, NSError *error);
/**
 *  开放LocationManager, 方便自定义
 */
@property (nonatomic, strong) CLLocationManager *location;

/**
 *  默认开启自动停止定位服务
 */
@property (nonatomic, assign) BOOL isAutoStopLocation;


/**
 *  初始化方法
 *
 *  @return 
 */
+(instancetype)manager;


/**
 *  开始定位，
 *
 *  @param Complete 回调的block
 */
-(void)startLoactionWithComplete:(locationBack)Complete;

/**
 *  停止定位
 */
-(void)stopUpdatingLocation;





/**
 *  使用说明：
 需要在info.plist文件里添加两个字段给APP定位权限。他们分别是
 NSLocationWhenInUseUsageDescription	使用期间
 NSLocationAlwaysUsageDescription	始终开启
 
 示例:
 
 HCLocationManager *locMgr = [HCLocationManager manager];
 [locMgr startLoactionWithComplete:^(NSString *city, CLPlacemark *placemark, CLLocation *currentLocation, NSError *error) {
 if (error) {
 // HCLog(@"定位失败，%@",error);
 return ;
 }

 
 }];
 
 *
 */


@end
