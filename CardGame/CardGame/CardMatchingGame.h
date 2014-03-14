//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Yang Chen on 3/11/14.
//  Copyright (c) 2014 Yang Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck  *)deck
                           inMode:(NSInteger)mode;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSInteger score;
@property (nonatomic)NSInteger mode;
@property (nonatomic)NSString *status;

@end
