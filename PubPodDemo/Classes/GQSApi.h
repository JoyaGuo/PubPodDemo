//
//  GQSApi.h
//  FBSnapshotTestCase
//
//  Created by 郭桥生 on 2018/10/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GQSApi : NSObject


/**
 初始化

 @param gqsSecret app注册secret
 */
+ (void)initWithSecret:(NSString *)gqsSecret;


/**
 检查secret是否注册成功

 @return 有效Yes
 */
+ (BOOL)secretValid;


/**
 分享到微信

 @param infoDictionary 字典类型参数
 */
+ (void)shareToWX:(NSDictionary *)infoDictionary;

@end

NS_ASSUME_NONNULL_END
