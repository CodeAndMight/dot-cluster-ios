//
//  XYZCluster.h
//  DotCluster
//
//  Created by Дмитрий on 10.07.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cluster : NSObject

/*!
 * @brief Количество кластеров
 */
@property (strong, nonatomic) NSNumber *number;

/*!
 * @brief Точки типа GCPoint вне кластера
 */
@property (strong, nonatomic) NSMutableArray *points;

/*!
 * @brief Точки в кластерах
 */
@property (strong, nonatomic) NSDictionary *clusters;

/*!
 * @discussion Выволняет кластеризацию при валидных параметрах
 */
- (void)test;

/*!
 * @discussion Очищает поле от точек
 */
- (void)clear;

/*!
 * @discussion Проверяет валидность параметров кластеризации
 */
- (BOOL)isValid;

@end
