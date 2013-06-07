//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by Francesco on 6/5/13.
//  Copyright (c) 2013 FrancescoAgosti. All rights reserved.
//

#import "ThreeCardMatchingGame.h"
#import "Card.h"

@interface ThreeCardMatchingGame()
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *message;
@property (strong, nonatomic) NSMutableArray *flippedCards;
@end

@implementation ThreeCardMatchingGame

#define MATCH_NUMBER 2
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_PENALTY 1

-(NSMutableArray *)flippedCards
{
    if(!_flippedCards) _flippedCards = [[NSMutableArray alloc] init];
    return _flippedCards;
}



-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.message = @"";
    if (!card.isUnplayable) {
        card.faceUp = !card.isFaceUp;
        if(card.isFaceUp){
            self.message=[NSString stringWithFormat:@"You flipped %@. It cost you %d point", card.contents, FLIP_PENALTY];
            
            if(self.flippedCards.count < MATCH_NUMBER){
               [self.flippedCards addObject:card]; 
            }
            else{
                NSMutableArray *temp = [self.flippedCards copy];
                [self.flippedCards removeAllObjects];
                int matchScore = [card match:temp];
                if(matchScore){
                    for(Card *otherCard in temp){
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    NSUInteger points = matchScore * MATCH_BONUS;
                    self.score += points;
                    self.message=[NSString stringWithFormat:@"%@,%@,%@ match! You gained %d points",card.contents, [temp[0] contents],[temp[1] contents], points];
                }else{
                    for(Card *otherCard in temp){
                        otherCard.faceUp = NO;
                    }
                    [self.flippedCards addObject:card];
                    self.score -= MISMATCH_PENALTY;
                    self.message=[NSString stringWithFormat:@"%@,%@,%@ don't match! You lost %d points", card.contents, [temp[0] contents],[temp[1] contents], MISMATCH_PENALTY];
                    
                }
                
            }
            self.score -= FLIP_PENALTY;
        }else{
            [self.flippedCards removeObject:card];
        }
    }
}



@end
