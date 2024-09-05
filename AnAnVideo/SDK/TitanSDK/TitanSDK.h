//
//  TitanSDK.h

#import <Foundation/Foundation.h>

@interface TitanSDK : NSObject

+(void)setToken:(NSInteger)token;
+(void)setListenPort:(NSInteger)port;
+(void)setPauseTimeout:(NSInteger)timeout;
+(void)setSleepTimeout:(NSInteger)timeout;
+(void)addHttpHeaderBypassKey:(NSString*)key;
+(void)start;
+(void)stop;

+ (NSString*)getVodUrl:(NSString*)fileUrl option:(NSString *)option;

+ (NSString*)getDownloadUrl:(NSString*)fileUrl option:(NSString *)option;

@end
