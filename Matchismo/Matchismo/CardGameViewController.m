//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Francesco on 5/28/13.
//  Copyright (c) 2013 FrancescoAgosti. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *cardDeck;
@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    Card *newCard = [self.cardDeck drawRandomCard];

    
    [sender setTitle:[newCard contents] forState:UIControlStateSelected];
    
    self.flipCount++;
    
}

-(Deck *)cardDeck
{
    if (!_cardDeck) {
        _cardDeck = [[PlayingCardDeck alloc]init];
    }
    return _cardDeck;
}




@end
