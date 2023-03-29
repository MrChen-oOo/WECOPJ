//
//  InveterInfoModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/28.
//

#import <Foundation/Foundation.h>
#import "InverModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InveterInfoModel : NSObject

@property (nonatomic, strong)InveterMsgInfoModel *dataModel;
@property (nonatomic, strong)NSMutableArray *inveterSectionOneArray;
@property (nonatomic, strong)NSMutableArray *inveterSectionTwoArray;
@property (nonatomic, strong)NSMutableArray *inveterSectionThreeArray;
-(void)addInveterSectionOneArray;


@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterKeyOneArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterKeyTwoArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterKeyThreeArray;
-(void)addInveterSectionTwoArray;

@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterValueOneArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterValueTwoArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterValueThreeArray;
-(void)addInveterSectionThreeArray;

@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterUnitOneArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterUnitTwoArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *inveterUnitThreeArray;


@end

NS_ASSUME_NONNULL_END
