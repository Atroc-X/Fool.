const weaapi = "https://v0.yiketianqi.com/api?unescape=1&version=v63&appid=23999117&appsecret=jY0K3wce"

$httpClient.get(weaapi, function(error, response, data){
    if (error){
        console.log(error);
        $done();                   
    } else {
        var obj = JSON.parse(data);
        console.log(obj);
        var city = "所在城市： " + obj.city;
        var wea = "天气状况： " + obj.wea + "  当前" + obj.tem + "℃  " + obj.tem2 + "℃～" + obj.tem1 + "℃";
        var air = "当前风力： " + obj.win + obj.win_speed + "  风速" + obj.win_meter + "\n空气指数： " + obj.air + "  " + obj.air_level + "\n友情提示： " + obj.air_tips;
        var alarms = obj.alarm.map(function(alarm) {
            return "天气警报： " + alarm.alarm_type + alarm.alarm_level;
        }).join("\n");
        var updateTime = "更新时间： " + obj.date + " "+ obj.update_time;
        let wmation = [city, wea, air + "\n" + alarms + "\n" + updateTime];
        $notification.post(wmation[0], wmation[1], wmation[2]);                
        $done();
    }
}
);
