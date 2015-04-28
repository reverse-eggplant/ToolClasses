//
//  DeviceIdentifierTool.h
//  DeviceIdentifier
//
//  Created by malong on 14/11/9.
//  Copyright (c) 2014年 malong. All rights reserved.
//

//设备唯一标示获取工具类

/*
 *获取的设备唯一标示的用途有：
 
 *1）用于一些统计与分析目的，利用用户的操作习惯和数据,更好的规划产品；
 *2）作为用户ID来唯一识别用户，可以用游客身份使用app,又能在服务器端保存相应的信息，省去了用户名、密码等注册过程。
 
*/

#import <Foundation/Foundation.h>


@interface DeviceIdentifierTool : NSObject


/*
 一、UDID （取不到、禁用）
 
 *UDID号:Unique Device Identifier 设备唯一标示符
 d获取代码：[[UIDevice currentDevice] uniqueIdentifier];
 
 该API在iOS以后被禁用
 */




/*
 二、Mac地址 （取的到，弃用）
 
 * 什么是MAC地址？
 * MAC(Media Access Control)地址，或称为 MAC位址、硬件位址，用来定义网络设备的位置,用来表示互联网上每一个站点的标识符，采用十六进制数表示，共六个字节（48位）。在OSI模型中，第三层网络层负责 IP地址，第二层数据链路层则负责 MAC位址。因此一个主机会有一个IP地址，而每个网络位置会有一个专属于它的MAC位址。
 
    MAC地址在网络上用来区分设备的唯一性，接入网络的设备都有一个MAC地址，他们肯定都是不同的，是唯一的。一部iPhone上可能有多个MAC地址，包括WIFI的、SIM的等，但是iTouch和iPad上就有一个WIFI的，因此只需获取WIFI的MAC地址就好了，也就是en0的地址。
     形象的说，MAC地址就如同我们身份证上的身份证号码，具有全球唯一性。这样就可以非常好的标识设备唯一性，类似与苹果设备的UDID号

    iOS7以后，不能再使用Mac地址做为设备唯一标示，因为Mac地址涉及到用户设备的隐私安全。如果我们请求获取Mac地址，系统会返回固定数值  02:00:00:00:00:00。
 */

+ (NSString *)getMacAddress;





/*
 三、UUID （取的到，常用）
 * UUID(Universally Unique Identifier)
 
 * 问题是如果用户删除该应用再次安装时，又会生成新的字符串，所以不能保证唯一识别该设备
 
 *通用唯一识别码。它是让分布式系统中的所有元素，都能有唯一的辨识资讯，而不需要透过中央控制端来做辨识资讯的指定。这样，每个人都可以建立不与其它人冲突的 UUID。在此情况下，就不需考虑数据库建立时的名称重复问题。苹果公司建议使用UUID为应用生成唯一标识字符串。
 */

+ (NSString *)getUUID;






/*
 四、OPEN UDID （取的到，慎用）
 
 *  OPEN UDID，没有用到MAC地址，同时能保证同一台设备上的不同应用使用同一个OpenUDID，只要用户设备上有一个使用了OpenUDID的应用存在时，其他后续安装的应用如果获取OpenUDID，都将会获得第一个应用生成的那个。但是根据贡献者的代码和方法，和一些开发者的经验，如果把使用了OpenUDID方案的应用全部都删除，再重新获取OpenUDID，此时的OpenUDID就跟以前的不一样。
 * 相关链接：http://blog.csdn.net/wwmusic/article/details/8929611
 
 
 */

+ (NSString *)getOpenUdId;



/*
 五、广告标示符 （取的到，不靠谱）
 
 *iOS 6中另外一个新的方法，提供了一个方法advertisingIdentifier，通过调用该方法会返回一个NSUUID实例，最后可以获得一个UUID，由系统存储着的。不过即使这是由系统存储的，但是有几种情况下，会重新生成广告标示符。如果用户完全重置系统（(设置程序 -> 通用 -> 还原 -> 还原位置与隐私) ，这个广告标示符会重新生成。另外如果用户明确的还原广告(设置程序-> 通用 -> 关于本机 -> 广告 -> 还原广告标示符) ，那么广告标示符也会重新生成。关于广告标示符的还原，有一点需要注意：如果程序在后台运行，此时用户“还原广告标示符”，然后再回到程序中，此时获取广 告标示符并不会立即获得还原后的标示符。必须要终止程序，然后再重新启动程序，才能获得还原后的广告标示符。
 
 
 */

+ (NSString *)getAdvertisingIdentifier;




/*
 六、Vendor标示符:ADF开发商 （取的到，不靠谱）
 
 ＊identifierForVendor
 
 *同一开发商的APP在指定机器上都会获得同一个ID。当我们删除了某一个设备上某个开发商的所有APP之后，下次获取将会获取到不同的ID。” 也就是说我们通过该接口不能获取用来唯一标识设备的ID
 
 */

+ (NSString *)getIdentifierForVendor;




/*
 七、token＋bundle_id (取的到，有风险)
 
 1、应用中增加推送用来获取token
 2、获取应用bundle_id
 3、根据token+bundle_id进行散列运算（hashvalue）
 
 * apple push token保证设备唯一，但必须有网络情况下才能工作，该方法不依赖于设备本身，但依赖于apple push，而苹果push有时候会抽风的。
 */



#pragma mark 安全办法：KeyChain(钥匙串)存储设备唯一标示符

//系统升级以后，仍然可以获取到之前记录的UDID数据.
//就算我们程序删除掉，系统经过升级以后再安装回来，依旧可以获取到与之前一致的UDID。
//系统还原后，不可以了

/*
 真机调试证书，浏览网页的账号和密码等都存放在钥匙串里。iOS中的KeyChain相比OS X比较简单，整个系统只有一个KeyChain，每个程序都可以往KeyChain中记录数据，而且只能读取到自己程序记录在KeyChain中的数据。iOS中Security.framework框架提供了四个主要的方法来操作KeyChain:
 
 * 原文地址：http://www.cnblogs.com/smileEvday/p/UDID.html
 
 // 查询
 OSStatus SecItemCopyMatching(CFDictionaryRef query, CFTypeRef *result);
 
 // 添加
 OSStatus SecItemAdd(CFDictionaryRef attributes, CFTypeRef *result);
 
 // 更新KeyChain中的Item
 OSStatus SecItemUpdate(CFDictionaryRef query, CFDictionaryRef attributesToUpdate);
 
 // 删除KeyChain中的Item
 OSStatus SecItemDelete(CFDictionaryRef query)
 
 
 */

@end
