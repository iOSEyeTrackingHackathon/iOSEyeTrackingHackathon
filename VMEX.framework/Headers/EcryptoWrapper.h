#import <Foundation/Foundation.h>

@interface EcryptoWrapper : NSObject
- (instancetype)init;
- (void)prepare;
- (void)setKeyPub_x: (NSString *)pub_x inPub_y:(NSString *)pub_y;
- (NSString *)ecryptingValue:(NSString *)value inIsHex:(BOOL)isHex;
- (void)decryptingPath: (NSString *)path inKey:(NSString *)key;
- (NSArray *)getKey;
- (NSArray *)getDH_value;

@end
