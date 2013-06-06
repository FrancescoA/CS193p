//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by Francesco on 6/5/13.
//  Copyright (c) 2013 FrancescoAgosti. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@interface ThreeCardMatchingGame()
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *message;
@end

@implementation ThreeCardMatchingGame


#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_PENALTY 1

-(void)flipCardAtIndex:(NSUInteger)index
{

    Card *card = [self cardAtIndex:index];
    self.message = @"";
    if (!card.isUnplayable) {
        if(!card.isFaceUp){
            self.message=[NSString stringWithFormat:@"You flipped %@. It cost you %d point", card.contents, FLIP_PENALTY];
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.unplayable){
                    int matchScore = [card match: @[otherCard]];
                    if(matchScore){
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        NSUInteger points = matchScore * MATCH_BONUS;
                        self.score += points;
                        self.message=[NSString stringWithFormat:@"You matched %@ and %@ and gained %d points", card.contents, otherCard.contents, points];
                    }
                    else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.message=[NSString stringWithFormat:@"%@ and %@ don't match! You lost %d points", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_PENALTY;
        }
        card.faceUp = !card.isFaceUp;
    }
    
    
}


@end
