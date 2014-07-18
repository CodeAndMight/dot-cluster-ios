//
//  XYZCluster.m
//  DotCluster
//
//  Created by Дмитрий on 10.07.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import "Cluster.h"

@implementation Cluster

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.number = @2;
        self.points = [NSMutableArray new];
        self.clusters = [NSDictionary new];
    }
    return self;
}

- (void)test
{
    if (![self isValid]) {
        return;
    }
    
    self.clusters = [self clusterWithPoints:self.points groups:self.number];
}

- (void)clear
{
    [self.points removeAllObjects];
    self.clusters = [NSDictionary new];
}

- (BOOL)isValid
{
    return self.points.count >= self.number.integerValue;
}

/*!
 * @discussion Вычисляет растояние между двумя точками
 */
- (double)distanceWithPoint:(NSValue *)point1 point:(NSValue *)point2
{
    return sqrt(pow(point1.CGPointValue.x - point2.CGPointValue.x, 2) +
                pow(point1.CGPointValue.y - point2.CGPointValue.y, 2));
}

/*!
 * @discussion Ищет самую центральную точки для остальных групп точек
 */
- (NSValue *)centroidWithCluster:(NSArray *)cluster
{
    NSNumber *minDist = nil;
    NSValue *element = nil;
    for (NSValue *point1 in cluster) {
        NSNumber *dist = @0.0;
        for (NSValue *point2 in cluster) {
            dist = @(dist.doubleValue + [self distanceWithPoint:point1 point:point2]);
        }
        if (minDist == nil || dist.doubleValue < minDist.doubleValue) {
            minDist = dist;
            element = point1;
        }
    }
    return element;
}

/*!
 * @discussion Проверяет на случай пустого кластера
 */
- (BOOL)isHoleInCluster:(NSDictionary *)v
{
    for (NSNumber *e in v) {
        NSArray *a = v[e];
        if (a.count == 0) {
            return YES;
        }
    }
    return NO;
}

/*!
 * @discussion Выполняет кластеризацию методом С-Means
 */
- (NSDictionary *)clusterWithPoints:(NSArray *)points groups:(NSNumber *)groups
{
    if (points.count == 0) {
        return [NSDictionary new];
    }
    
    srand(time(NULL));
    
    NSMutableDictionary *clusters = nil;
    
    while (clusters == nil || [self isHoleInCluster:clusters]) {
        clusters = [NSMutableDictionary new];
        
        // Создание групп пустых клстеров
        for (int i = 0; i < groups.intValue; i++) {
            [clusters setObject:[NSMutableArray new] forKey:@(i)];
        }
        
        // Случайно распределяем все точки по кластерам
        for (NSValue *point in points) {
            NSNumber *g = @(rand() % groups.intValue);
            [clusters[g] addObject:point];
        }
    }
    
    BOOL modified = YES;
    while (modified) {
        NSMutableArray *centroids = [NSMutableArray new];
        
        // Вычислить центроиды для каждого кластера
        for (int i = 0; i < groups.intValue; i++) {
            [centroids addObject:[self centroidWithCluster:clusters[@(i)]]];
        }
        modified = NO;
        NSMutableDictionary *newClusters = [NSMutableDictionary new];
        
        // Создать группу новых пустых кластеров
        for (int i = 0; i < groups.intValue; i++) {
            [newClusters setObject:[NSMutableArray new] forKey:@(i)];
        }
        
        for (int oldCl = 0; oldCl < groups.intValue; oldCl++) {
            for (NSValue *c in clusters[@(oldCl)]) {
                NSNumber *minDist = nil;
                NSNumber *clusterNo = 0;
                
                // Переместить точку в другой кластер, если существует для него центроид
                for (int cd = 0; cd < groups.intValue; cd++) {
                    double dist = [self distanceWithPoint:c point:[centroids objectAtIndex:cd]];
                    
                    if (minDist == nil || dist < minDist.doubleValue) {
                        minDist = @(dist);
                        clusterNo = @(cd);
                    }
                }
                if (clusterNo.intValue != oldCl) {
                    modified = YES;
                }
                [newClusters[clusterNo] addObject:c];
            }
        }
        clusters = newClusters;
    }
    return clusters;
}

@end
