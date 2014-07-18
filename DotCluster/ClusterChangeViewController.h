//
//  XYZClusterChangeViewController.h
//  DotCluster
//
//  Created by Дмитрий on 10.07.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClusterChangeViewController : UIViewController

/*!
 * @breaf Количество кластеров, выбранное пользователем
 */
@property (strong, nonatomic) NSNumber *valueNumber;

/*!
 * @discussion Выполняет изменения в поле, которое информирует пользователя о текущем количестве кластеров
 * @param sender Контрол, который активирует пользователь
 */
- (IBAction)changeValue:(UIStepper *)sender;

@end
