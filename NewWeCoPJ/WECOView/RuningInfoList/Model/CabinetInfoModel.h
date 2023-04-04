//
//  CabinetInfoModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <Foundation/Foundation.h>
#import "CabinetModel.h"


@interface CabinetInfoModel : NSObject

@property (nonatomic, strong)CabinetMsgInfoModel* cabinetModel;

@property (nonatomic, strong)NSMutableArray *cabinetSectionOneArray;
@property (nonatomic, strong)NSMutableArray *cabinetSectionTwoArray;
@property (nonatomic, strong)NSMutableArray *cabinetSectionThreeArray;
-(void)addICabinetSectionOneArrayWithIndex:(NSInteger)index;


@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetKeyOneArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetKeyTwoArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetKeyThreeArray;
-(void)addICabinetSectionTwoArrayWithIndex:(NSInteger)index;

@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetValueOneArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetValueTwoArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetValueThreeArray;
-(void)addICabinetSectionThreeArray;

@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetUnitOneArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetUnitTwoArray;
@property (nonatomic, strong)NSMutableArray<NSArray *> *cabinetUnitThreeArray;


@end


