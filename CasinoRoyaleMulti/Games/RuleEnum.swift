//
//  RuleEnum.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation


enum RuleEnum {
    case twentyOne
    case roulette
    case kubiki
    
    
    var image: String {
        switch self {
        case .twentyOne:
            return "21numbers"
        case .roulette:
            return "torquz"
        case .kubiki:
            return  "6"
        }
    }
    var rule: String {
       
        switch self {
        case .twentyOne:
             return "In the game 21, players aim to get a card total of 21 or close, without exceeding it. Cards 2-10 are face value; Jacks, Queens, and Kings are 10; Aces are 1 or 11. Players and the dealer get two cards: one dealer card is hidden. Players can take cards, stop, double down, split pairs, or insure. Dealers must hit if under 17. Closest to 21 wins. Blackjack (Ace + 10) beats 21. Ties return the bet."
            
        case .roulette:
            return "In roulette, the objective is to predict the number or color where the ball will land. Players can wager on a specific number, offering a payout of 35:1, or on a color (red or black), which pays 1:1. Betting on numbers involves higher risk but greater rewards, while color bets are safer with smaller payouts. After placing your bet, the wheel spins, and your winnings are determined based on the outcome."
            
        case .kubiki:
            return "In a dice game, players place bets, roll the dice, and sum the points on the rolled faces. The player with the higher total wins the round and doubles their bet, while ties result in the bet being returned. The game continues for a set number of rounds or until players agree to stop."
        }
    }
}
