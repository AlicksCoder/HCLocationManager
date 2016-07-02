//
//  HCLocationManager.m
//  Traveling
//
//  Created by ZHC on 16/7/2.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "HCLocationManager.h"
#import <UIKit/UIKit.h>
@interface HCLocationManager () <CLLocationManagerDelegate>
{
    locationBack _locationBack;
}
@end

@implementation HCLocationManager


+(instancetype)manager{
    static HCLocationManager *_HCLogMgr = nil;
    static dispatch_once_t onceTokeHCLogMgr;
    dispatch_once(&onceTokeHCLogMgr, ^{
        _HCLogMgr = [[super allocWithZone:NULL]init];
        _HCLogMgr.isAutoStopLocation = YES;
    });
    
    return _HCLogMgr;
   
}

+(instancetype)alloc{
    
    return [self manager];
}


-(void)startLoactionWithComplete:(locationBack)complete{
    if (complete) {
        _locationBack = complete;
    }
    
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]&&([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
                                                     ||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse
                                                     || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined))
    {
        
        //定位初始化
        if (!self.location) {
            self.location = [[CLLocationManager alloc] init];
            self.location.delegate= self;
            self.location.desiredAccuracy=kCLLocationAccuracyBest;
            self.location.distanceFilter=10;
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
                [self.location requestWhenInUseAuthorization];
            }
            
        }
        //开启定位
        [self.location startUpdatingLocation];
        
    }else {
        //提示用户无法进行定位操作
        if (complete) {
            
            NSError *error = [NSError errorWithDomain:@"定位开启失败" code:800 userInfo:nil];
            
            complete(nil, nil, nil, error);
        }
    }


}


#pragma mark - CLLocationManagerDelegate
/**
 *  只要定位到用户的位置，就会调用（调用频率特别高）
 *  @param locations : 装着CLLocation对象
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
//             HCLog(@"---%@",placemark.name);//具体位置
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
//            HCLog(@"---city%@",city);
             
             if (_locationBack) {
                 _locationBack(city, placemark, currentLocation, nil);
             }
             
             //系统会一直更新数据，直到选择停止更新
             if (self.isAutoStopLocation) {
                 [self stopUpdatingLocation];
             }
             
             
         }else if (error == nil && [array count] == 0)
         {
             if (_locationBack) {
                 NSError *error1 = [NSError errorWithDomain:@"无法获取的位置信息" code:900 userInfo:nil];
                 _locationBack(nil, nil, nil, error1);
             }
         }else if (error != nil)
         {
             _locationBack(nil, nil, nil, error);
         }
     }];
}


-(void)stopUpdatingLocation{
    [_location stopUpdatingLocation];
}

@end
