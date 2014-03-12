//
//  PlayingCard.h
//  CardGame
//
//  Created by Yang Chen on 3/9/14.
//  Copyright (c) 2014 Yang Chen. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
