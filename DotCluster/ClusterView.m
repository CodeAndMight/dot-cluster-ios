//
//  XYZClusterView.m
//  DotCluster
//
//  Created by Дмитрий on 10.07.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import "ClusterView.h"

@implementation ClusterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*!
 * @discussion Создает цвет для нового кластера
 * @param number Номер кластера
 * @return Возвращает цвет типа CGColorRef
 */
- (CGColorRef)colorWithNumber:(NSUInteger)number
{
    switch (number) {
        case 1:
            return [UIColor redColor].CGColor;

        case 2:
            return [UIColor greenColor].CGColor;
            
        case 3:
            return [UIColor blueColor].CGColor;
            
        case 4:
            return [UIColor orangeColor].CGColor;
            
        case 5:
            return [UIColor purpleColor].CGColor;
            
        case 6:
            return [UIColor brownColor].CGColor;
            
        case 7:
            return [UIColor magentaColor].CGColor;
            
        case 8:
            return [UIColor yellowColor].CGColor;
            
        case 9:
            return [UIColor lightGrayColor].CGColor;
            
        case 10:
            return [UIColor cyanColor].CGColor;
            
        default:
            return [UIColor blackColor].CGColor;
    }
}

/*!
 * @discussion Рисует в контексте окружность цветом кластера
 * @param value Содержит информацио о точке CGPoint
 * @param aColorNumber Номер цвета для кластера
 * @param context Текущий контект графики
 */
- (void)drawCircleWithValue:(NSValue *)value colorNumber:(NSNumber *)aColorNumber context:(CGContextRef)context
{
    CGPoint point = value.CGPointValue;
    CGColorRef color = [self colorWithNumber:aColorNumber.integerValue];
    CGRect rectangle = CGRectMake(point.x, point.y, 3, 3);
    
    CGContextSetStrokeColorWithColor(context, color);
    CGContextAddEllipseInRect(context, rectangle);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Отобразить точки вне кластера
    for (NSValue *value in self.cluster.points) {
        [self drawCircleWithValue:value colorNumber:@0 context:context];
    }
    CGContextStrokePath(context);

    // Отобразить точки цветом его кластера
    for (NSNumber *key in self.cluster.clusters) {
        NSArray *cluster = self.cluster.clusters[key];
        for (NSValue *value in cluster) {
            [self drawCircleWithValue:value colorNumber:@(key.integerValue + 1) context:context];
        }
        CGContextStrokePath(context);
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSValue *value = [NSValue valueWithCGPoint:point];
    
    // Пользователь добавляет новую точку, следует обновить экран
    
    [self.cluster.points addObject:value];
    [self setNeedsDisplay];
}

@end
