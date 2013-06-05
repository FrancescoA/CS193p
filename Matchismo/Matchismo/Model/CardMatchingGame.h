//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Francesco on 6/3/13.
//  Copyright (c) 2013 FrancescoAgosti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *message;

//designated inizializer
-(id)initWithCardCount:(NSUInteger) cardCount
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;


@end
