//
//  XYZClusterView.h
//  DotCluster
//
//  Created by Дмитрий on 10.07.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Cluster.h"

@interface ClusterView : UIView

/*!
 * @brief Содержит точки, кластеры, выполняет алгоритм кластеризации
 */
@property (strong, nonatomic) Cluster *cluster;

@end
