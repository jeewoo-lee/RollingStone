//
//  main.swift
//  RollingStone
//
//  Created by Anstoetz, Nick on 2020-03-11.
//  Copyright © 2020 Anstoetz, Nick. All rights reserved.
//

import Foundation

// Add functionality to the Card structure
extension Card {
    
    // Computed property that returns true when the card is a face card (class work)
    var isFaceCard: Bool {
        if self.rank == .ace ||
            self.rank == .king ||
            self.rank == .queen ||
            self.rank == .jack {
                return true
        } else {
            return false
        }
    }
}


class RollingStone {
    
    //create the deck
    var deck : Deck
    var actualDeck: Deck
    
    //creating the 6 users
    var player1 : Hand
    var player2 : Hand
    var player3 : Hand
    var player4 : Hand
    var player5 : Hand
    var player6 : Hand
    
    //playerOfTheTurn
    var playerOfTheTurn : Hand

    //adding the middle to add cards to
    var middle : Hand

    //choosing the how many players should play
    let minPlayernumber = 4
    let maxPlayernumber = 6
    init(){
        player1 = Hand(description: "none")
        player2 = Hand(description: "none")
        player3 = Hand(description: "none")
        player4 = Hand(description: "none")
        player5 = Hand(description: "none")
        player6 = Hand(description: "none")
        
        middle = Hand(description: "middle")
        deck = Deck()
        actualDeck = Deck()
        actualDeck.reset()
        
        var possibleNumber = 0
        while true{
            print("Please Enter a number between 4-6 of the players you want to play with")
            guard let numberInput = readLine(), let playerCount = Int(numberInput) else {
                continue
            }
            possibleNumber = playerCount
            break
        }
        
        if possibleNumber == 4 {
            print("Please Enter the name of four players you want to play with")
            player1 = Hand(description: readLine()!)
            player2 = Hand(description: readLine()!)
            player3 = Hand(description: readLine()!)
            player4 = Hand(description: readLine()!)
            player5 = Hand(description: "none")
            player6 = Hand(description: "none")
            
            //remove 2-6 from deck
               for i in 0...deck.cards.count - 1 {
                   let theRank = deck.cards[i].rank.rawValue
                   if theRank != 2 && theRank != 3 && theRank != 4 && theRank != 5 && theRank != 6 {
                      
                    actualDeck.cards.append(deck.cards[i])
                }
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player1.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player2.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player3.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player4.cards = newCards
            }
        }
            
        else if possibleNumber == 5 {
            print("Please Enter the name of five players you want to play with")
            player1 = Hand(description: readLine()!)
            player2 = Hand(description: readLine()!)
            player3 = Hand(description: readLine()!)
            player4 = Hand(description: readLine()!)
            player5 = Hand(description: readLine()!)
            player6 = Hand(description: "none")
            
            
            //add cards from 2-5 from deck
            for i in 0...deck.cards.count - 1 {
                let theRank = deck.cards[i].rank.rawValue
                if theRank != 2 && theRank != 3 && theRank != 4 {
                   
                    actualDeck.cards.append(deck.cards[i])
                }
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player1.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player2.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player3.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player4.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player5.cards = newCards
            }
        }
        else if possibleNumber == 6 {
            print("Please Enter the name of six players you want to play with")
            player1 = Hand(description: readLine()!)
            player2 = Hand(description: readLine()!)
            player3 = Hand(description: readLine()!)
            player4 = Hand(description: readLine()!)
            player5 = Hand(description: readLine()!)
            player6 = Hand(description: readLine()!)
            
            //remove 2-4 form deck
           for i in 0...deck.cards.count - 1 {
               let theRank = deck.cards[i].rank.rawValue
               if theRank != 2 {
                  
                actualDeck.cards.append(deck.cards[i])
               }
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player1.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player2.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player3.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player4.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player5.cards = newCards
            }
            if let newCards = self.actualDeck.randomlyDealOut(thisManyCards: 8) {
                player6.cards = newCards
            }
     
        }else{
        print("restart and type number between 4-6")
        }
        
        //temporarily player1 starts the game.
        playerOfTheTurn = player1
    }
    
    func checkIfThereIsCardToPutDown(who thePlayer: Hand) {
        let cardOnMiddle = middle.cards[0]
        for i in 0...thePlayer.cards.count - 1 {
            if thePlayer.cards[i].suit == cardOnMiddle.suit {
                middle.cards.insert(thePlayer.cards[i], at: 0)
                thePlayer.cards.remove(at: i)
            } else {
                thePlayer.cards.insert(contentsOf: middle.cards, at: 0)
                middle.cards.removeAll()
            }
        }
    }
    
    func isGameOver() -> Bool {
        if playerOfTheTurn.cards.count == 0 {
            announceWinner()
            return true
        } else {
            return false
        }
    }
    
    func announceWinner() {
        print(playerOfTheTurn.description + " is the winner")
    }
}
RollingStone()

