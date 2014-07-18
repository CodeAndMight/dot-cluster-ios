//
//  XYZDotClusterViewController.h
//  DotCluster
//
//  Created by Дмитрий on 10.07.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClusterView.h"

@interface DotClusterViewController : UIViewController

/*!
 * @brief Холст, отображающий точки пользователя. Также отображаются разными цветами точки разбитые по кластерам
 */
@property (weak, nonatomic) IBOutlet ClusterView *clusterView;

/*!
 * @discussion Метод обрабатывает ответ от контроллера с изменением количества кластеров
 * @param segue Содержит контроллер с переданным количеством кластеров
 */
- (IBAction)unwindToCluster:(UIStoryboardSegue *)segue;

/*!
 * @discussion Метод запускает кластеризацию в случае валидных параметров (точек, кластеров)
 * @param sender Кнопка нажатая пользователем
 */
- (IBAction)testCluster:(id)sender;

@end
