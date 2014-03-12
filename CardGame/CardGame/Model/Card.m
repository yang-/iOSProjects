//
//  Card.m
//  CardGame
//
//  Created by Yang Chen on 3/9/14.
//  Copyright (c) 2014 Yang Chen. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards {
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
