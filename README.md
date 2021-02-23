# dfmdsapp

组件名文件名用中划线连接，  
lib/router 配置路由  

flutter run  启动本地  
flutter build  apk  打包Android  后面跟对应架构可打分包  

## lib api

http 为封装Dio网络请求部分    
　　--dio.dart Dio实例  
　　--env.dart 为环境变量文件  存放接口host  
　　--httpCode.dart 为后端自定义返回code码  
　　--msg.dart 为消息广播类  触发event_bus广播  
　　--socket.dart 为消息长链接， mStream为初始化后的socket，可添加监听  

api 为存放接口文件 index.dart统一把接口暴露出来  
　　--index.dart统一把接口暴露出来  
　　--common.dart 公用接口  

## lib assets

静态资源存放目录   
　　--iconfont  svg带颜色图标使用方法    
　　--icons  阿里图标库图标    
　　--images  图片存放目录，在pubspec.yaml中添加本地图片      

## lib components

appBar 统一头部  传入标题名titleData和是否返回刷新refresh


## lib config

存放进入app需要初始化的插件等 

## lib pages

主开发页面

## lib router

配置路由

## lib utils

存放工具  
　　--index.dart 暴露工具集合    
　　--path_provider.dart 键值对存储方法集合    
　　--picker.dart 底部弹窗选择控件    
　　--pxunit.dart 适配和px转换 设计图为375    
　　--storage.dart 文件存储    
　　--toast.dart toast集合    
　　--version_update.dart 应用内更新    

## iconfont
全局安装
```
npm install flutter-iconfont-cli -g
```
在iconfont.js中修改symbol_url为阿里图标库中js链接  
生成组件
```
npx iconfont-flutter
```
使用
```
class App extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return IconFont(IconNames.alipay, size: 100, colors: ['green', 'orange']);
    }
}
```
## mac模拟器无法联网
```
cd /Users/shinho/Library/Android/sdk/emulator
```
```
./emulator @Pixel_3_XL_API_30 -dns-server 8.8.8.8,114.114.114.114
```


