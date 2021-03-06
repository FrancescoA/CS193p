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
#import "CardMatchingGame.h"
#import "ThreeCardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *outcomeLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) UIImage *cardback;
@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
}

-(CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}


-(UIImage *)cardback
{
    if(!_cardback) _cardback = [UIImage imageNamed:@"cardback.jpg"];
    return _cardback;
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        card.isFaceUp ? [cardButton setImage:nil forState:UIControlStateNormal] : [cardButton setImage:self.cardback forState:UIControlStateNormal];
        
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.outcomeLabel.text = self.game.message;
    
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}
- (IBAction)deal {
    [self setSegmentStateTo:YES];
    self.game = [[[self.game class] alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)gameTypeSelect:(UISegmentedControl *)sender {
    Deck *toBeUsed = [[PlayingCardDeck alloc] init];
    self.game = sender.selectedSegmentIndex ?
    [[ThreeCardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:toBeUsed]
    : [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck: toBeUsed];
    

    
}

-(void)setSegmentStateTo:(BOOL)setting
{
    [_segmentedControl setEnabled:setting];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self setSegmentStateTo:NO];
    [self updateUI];
    
}


@end
