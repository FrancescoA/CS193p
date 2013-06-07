//
//  PlayingCard.m
//  Matchismo
//
//  Created by Francesco on 6/1/13.
//  Copyright (c) 2013 FrancescoAgosti. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+(NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♠",@"♣", @"♥", @"♦"];
    return validSuits;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    NSMutableArray *mutableCards = [otherCards mutableCopy];
    [mutableCards addObject:self];
    
    for(int i=0 ; i < mutableCards.count ; i++){
        for(int j=i+1 ;j <mutableCards.count ; j++){
            PlayingCard *x = mutableCards[i];
            PlayingCard *y = mutableCards[j];
            
            if([x.suit isEqualToString:y.suit]){
                score += 1;
            }else if(x.rank == y.rank){
                score +=4;
            }
        }
    }
    
    return score;
}


-(void)setSuit:(NSString *)suit;
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [self rankStrings].count -1;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
    
}

@end
