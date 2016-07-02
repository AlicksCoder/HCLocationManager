# HCLocationManager
轻松获取位置信息，城市，经纬度，错误，一个Block解决 <br/>
HCLocationManager *locMgr = [HCLocationManager manager];    <br/>
[locMgr startLoactionWithComplete:^(NSString *city, CLPlacemark *placemark, CLLocation *currentLocation, NSError *error)<br> {<br>
        if (error) {    <br>
            // HCLog(@"定位失败，%@",error);    <br>
            return ;<br>
        }<br>
        <br>
        NSLog(@"city --- %@------%@",city,placemark.name);<br>
        <br>
    }<br>
    ];<br>
    
    
