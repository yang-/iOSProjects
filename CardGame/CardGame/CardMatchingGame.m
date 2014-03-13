//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Yang Chen on 3/11/14.
//  Copyright (c) 2014 Yang Chen. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; // of Card
@property (nonatomic, strong)NSMutableArray *otherCards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSMutableArray *)otherCards
{
    if (!_otherCards) _otherCards = [[NSMutableArray alloc] init];
    return _otherCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck inMode:(NSInteger)mode
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.mode = mode;
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [self.otherCards addObject:otherCard];
                    NSLog(@"otherCards addObject: %@", otherCard.contents);
//                    int matchScore = [card match:@[otherCard]];
//                    if (matchScore) {
//                        self.score += matchScore * MATCH_BONUS;
//                        otherCard.matched = YES;
//                        card.matched = YES;
//                    } else {
//                        self.score -= MISMATCH_PENALTY;
//                        otherCard.chosen = NO;
//                    }
//                    break;
                    if ([self.otherCards count] == self.mode - 1) {
                        int matchScore = [card match:self.otherCards];
                        NSLog(@"%@ is matching array of %@ and %@", card.contents, ((Card *)[self.otherCards firstObject]).contents , ((Card *)[self.otherCards lastObject]).contents);
                        NSLog(@"math score: %d", matchScore);
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            for (Card *choosedCard in self.otherCards) {
                                choosedCard.matched = YES;
                            }
                            card.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            for (Card *choosedCard in self.otherCards) {
                                choosedCard.chosen = NO;
                            }
                        }
//                        self.otherCards = nil;
                        break;
                    }
                    
                }
            }
            self.otherCards = nil;
            NSLog(@"otherCards reset");
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
}

@end
