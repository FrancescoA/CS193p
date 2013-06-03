//
//  PlayingCard.h
//  Matchismo
//
//  Created by Francesco on 6/1/13.
//  Copyright (c) 2013 FrancescoAgosti. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
