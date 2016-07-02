# HCLocationManager
轻松获取位置信息，城市，经纬度，错误，一个Block解决 <br/>

```
    HCLocationManager *locMgr = [HCLocationManager manager];  
    [locMgr startLoactionWithComplete:^(NSString *city, CLPlacemark *placemark, CLLocation *currentLocation, NSError *error)<br> {

            if (error) {        
                // HCLog(@"定位失败，%@",error);     
                return ;
            }

            NSLog(@"city --- %@------%@",city,placemark.name);

        }
    ];
```
    
