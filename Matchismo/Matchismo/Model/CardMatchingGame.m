//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Francesco on 6/3/13.
//  Copyright (c) 2013 FrancescoAgosti. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self) {
        for(int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
                break;
            } else {
                self.cards[i] = card;
            }
            
        }
        
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
