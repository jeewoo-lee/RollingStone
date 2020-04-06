//
//  main.swift
//  RollingStone
//
//  Created by Anstoetz-Lee on 2020-03-11.
//  Copyright © 2020 Anstoetz-Lee. All rights reserved.
//

import Foundation
import Darwin

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
    //determine if game is on
    var isGameOn = false
    //variable needed for making "human readable game"
    var shouldStartNewRound = false
    var round = 1
    var interactiveMode: Bool
    
    //create the deck
    var deck : Deck
    var actualDeck: Deck
    
    //creating the 6 players of order
    var player1 : Hand
    var player2 : Hand
    var player3 : Hand
    var player4 : Hand
    var player5 : Hand
    var player6 : Hand
    
    var firstP : Hand
    var secondP : Hand
    var thirdP : Hand
    var fourthP : Hand
    var fithP : Hand
    var sixthP : Hand

    //creating the 6 players of user input
//    var firstP : Hand
//    var secondP : Hand
//    var thirdP : Hand
//    var fourthP : Hand
    
    //keep tracking the turn
    var dealer : Hand
    var playerAtTurn : Hand
    var nextPlayer : Hand
    
    //adding the middle to add cards to
    var middle : Hand
    
    //var players : [Hand]

    //choosing the how many players should play
    let minPlayernumber = 4
    let maxPlayernumber = 6
    init(interactiveMode: Bool = false){
        //Mr. Gordon's code
        // Wait for user input while playing?
        self.interactiveMode = interactiveMode
        
        //Initialize players
        firstP = Hand(description: "none")
        secondP = Hand(description: "none")
        thirdP = Hand(description: "none")
        fourthP = Hand(description: "none")
        fithP = Hand(description: "none")
        sixthP = Hand(description: "none")
        
        //default start
        player1 = firstP
        player2 = secondP
        player3 = thirdP
        player4 = fourthP
        player5 = fithP
        player6 = sixthP
        
        dealer = player4
        playerAtTurn = player1
        nextPlayer = player2
        
        //difficulties related to this code, players = [player1, player2, player3, player4, player5, player6]: how to determine the order? I (Jeewoo) thought it would be good idea for making the players array that keep tracts of whose turn it is. For example, playerOfTurn: players[0], nextPlayerOfTurn: players[1]. I expected the values of array to point same memory location as other players since instances of classes are reference types. However, it turns out as those hands(players) are stored in array, it creates copy of those players that it does not point same memory location anymore. I assume it's because collections in swift are value types.

        //initialize middle which is instance of Hand class
        middle = Hand(description: "middle")
        //Initialize Deck
        deck = Deck()
        //Initialize actual deck that will be used in actual game
        actualDeck = Deck()
        //empty the array of actaulDeck because we want it to have no cards before user determine how many people they would like to play with.
        actualDeck.reset()
        
        //set possibleNumber; number of players as 0 before user input
        var possibleNumber = 0
        //get user input for possibleNumber of players.
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
            firstP = Hand(description: readLine()!)
            secondP = Hand(description: readLine()!)
            thirdP = Hand(description: readLine()!)
            fourthP = Hand(description: readLine()!)
            
            starterForFourPlayer()
            
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
            
            //remove player5 and player6
//            players.removeLast()
//            players.removeLast()
            
            
            
        }
            
        else if possibleNumber == 5 {
            print("Please Enter the name of five players you want to play with")
            firstP = Hand(description: readLine()!)
            secondP = Hand(description: readLine()!)
            thirdP = Hand(description: readLine()!)
            fourthP = Hand(description: readLine()!)
            fithP = Hand(description: readLine()!)

            starterForFivePlayer()
            
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
            
            //remove player6
            //players.removeLast()
        }
        else if possibleNumber == 6 {
            print("Please Enter the name of six players you want to play with")
            firstP = Hand(description: readLine()!)
            secondP = Hand(description: readLine()!)
            thirdP = Hand(description: readLine()!)
            fourthP = Hand(description: readLine()!)
            fithP = Hand(description: readLine()!)
            sixthP = Hand(description: readLine()!)
            
            starterForSixPlayer()
            
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
        dealer = player4
        playerAtTurn = player1
        nextPlayer = player2
        middle.cards.insert(playerAtTurn.cards[0], at: 0)
        playerAtTurn.cards.remove(at: 0)
        start(number: possibleNumber)
    }
    
    func start(number: Int) {
        isGameOn = true
        while isGameOn == true {
            play(number: number)
        }
    }
    
    func play(number: Int) {
        if number == 4 {
            player1Turn()
            player2Turn()
            player3Turn()
            player4Turn(number: number)
        } else if number == 5 {
            player1Turn()
            player2Turn()
            player3Turn()
            player4Turn(number: number)
            player5Turn(number: number)
        } else {
            player1Turn()
            player2Turn()
            player3Turn()
            player4Turn(number: number)
            player5Turn(number: number)
            player6Turn()
        }
    }
    
//    func nextPersonsTurn() {
//        playerAtTurn = players[1]
//        players.append(players[0])
//        players.remove(at: 0)
//
//    }
    
    func player1Turn() {
        playerAtTurn = player1
        nextPlayer = player2
        print(playerAtTurn.description + " is at turn")
        checkIfThereIsCardToPutDown(who: playerAtTurn, who: nextPlayer)
    }
    
    func player2Turn() {
        playerAtTurn = player2
        nextPlayer = player3
        print(playerAtTurn.description + " is at turn")
        checkIfThereIsCardToPutDown(who: playerAtTurn, who: nextPlayer)
    }
    
    func player3Turn() {
        playerAtTurn = player3
        nextPlayer = player4
        print(playerAtTurn.description + " is at turn")
        checkIfThereIsCardToPutDown(who: playerAtTurn, who: nextPlayer)
    }
    
    func player4Turn(number number: Int) {
        playerAtTurn = player4
        if number == 4 {
            nextPlayer = player1
        } else {
            nextPlayer = player5
        }
        
        print(playerAtTurn.description + " is at turn")
        checkIfThereIsCardToPutDown(who: playerAtTurn, who: nextPlayer)
    }
    
    func player5Turn(number number: Int) {
        playerAtTurn = player5
        if number == 5 {
            nextPlayer = player1
        } else {
            nextPlayer = player6
        }
        print(playerAtTurn.description + " is at turn")
        checkIfThereIsCardToPutDown(who: playerAtTurn, who: nextPlayer)
    }
    
    func player6Turn() {
        playerAtTurn = player6
        nextPlayer = player1
        print(playerAtTurn.description + " is at turn")
        checkIfThereIsCardToPutDown(who: playerAtTurn, who: nextPlayer)
    }
    
    
    func checkIfThereIsCardToPutDown(who thePlayer: Hand, who nextPlayer: Hand) {
        waitForUserInput()
        rounds(rounds: round)
        if shouldStartNewRound == false {
            
            let cardOnMiddle = middle.cards[0]
            print("middle: " + middle.cards[0].simpleDescription())
            for i in 0...thePlayer.cards.count - 1 {
                print("player going through... " + thePlayer.cards[i].simpleDescription())
                if thePlayer.cards[i].suit == cardOnMiddle.suit {
                    middle.cards.insert(thePlayer.cards[i], at: 0)
                    print("player have played... " + thePlayer.cards[i].simpleDescription())
                    thePlayer.cards.remove(at: i)
                    break
                } else if i == thePlayer.cards.count - 1 {
                    round += 1
                    thePlayer.cards.insert(contentsOf: middle.cards, at: 0)
                    middle.cards.removeAll()
                    findCard(thePlayer: nextPlayer, theCard: cardOnMiddle)
                    shouldStartNewRound = true
                    break
                }
               
            }
            
            
        } else {
            checkWin(who: nextPlayer)
            if middle.cards.count > 0 {
                print(middle.cards[0].simpleDescription())
                shouldStartNewRound = false
            } else {
                print("There is no card in the middle")
            }
            
        }
        
        
        checkWin(who: thePlayer)
        describeCards(in: thePlayer)
        
    }
    func starterForFourPlayer() {
        var varFirstCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
        var varSecondCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
        var varThirdCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
        var varFourthCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue

        let cardsArray = [varFirstCard, varSecondCard, varThirdCard, varFourthCard]
        
        while true{
            guard let maxValue = cardsArray.max(), let theIndex = cardsArray.firstIndex(of: maxValue) else {
                varFirstCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                varSecondCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                varThirdCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                varFourthCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                continue
            }
 
             if theIndex == 0 {
                player1 = firstP
                player2 = secondP
                player3 = thirdP
                player4 = fourthP
                print("\(firstP.description) starts")
             } else if theIndex ==  1{
                player1 = secondP
                player2 = thirdP
                player3 = fourthP
                player4 = firstP
                print("\(secondP.description) starts")
            }
            else if theIndex == 2 {
                player1 = thirdP
                player2 = fourthP
                player3 = firstP
                player4 = secondP
                print("\(thirdP.description) starts")
            }
            else if theIndex == 3 {
                player1 = fourthP
                player2 = firstP
                player3 = secondP
                player4 = thirdP
                print("\(fourthP.description) starts")
            }
            break
        }
    }
    
func starterForFivePlayer() {
    var varFirstCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
    var varSecondCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
    var varThirdCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
    var varFourthCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
    var varFithCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue

    let cardsArray = [varFirstCard, varSecondCard, varThirdCard, varFourthCard, varFithCard]
           
    while true{
        guard let maxValue = cardsArray.max(), let theIndex = cardsArray.firstIndex(of: maxValue) else {
            varFirstCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
            varSecondCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
            varThirdCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
            varFourthCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
            varFithCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
               continue
           }

        if theIndex == 0 {
            player1 = firstP
            player2 = secondP
            player3 = thirdP
            player4 = fourthP
            player5 = fithP

            print("\(firstP.description) starts")
        } else if theIndex ==  1{
            player1 = secondP
            player2 = thirdP
            player3 = fourthP
            player4 = fithP
            player5 = firstP
            print("\(secondP.description) starts")
        }
        else if theIndex == 2 {
            player1 = thirdP
            player2 = fourthP
            player3 = fithP
            player4 = firstP
            player5 = secondP
            print("\(thirdP.description) starts")
        }
        else if theIndex == 3 {
            player1 = fourthP
            player2 = fithP
            player3 = firstP
            player4 = secondP
            player5 = thirdP
            print("\(fourthP.description) starts")
        }
        else if theIndex == 4 {
            player1 = fithP
            player2 = firstP
            player3 = secondP
            player4 = thirdP
            player5 = fourthP
            print("\(fithP.description) starts")
        }
        break
    }
  }
    
    func starterForSixPlayer() {
        var varFirstCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
        var varSecondCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
        var varThirdCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
        var varFourthCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
        var varFithCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
        var varSixthCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
           
        let cardsArray = [varFirstCard, varSecondCard, varThirdCard, varFourthCard, varFithCard, varSixthCard]
           
        while true{
            guard let maxValue = cardsArray.max(), let theIndex = cardsArray.firstIndex(of: maxValue) else {
                varFirstCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                varSecondCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                varThirdCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                varFourthCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                varFithCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                varSixthCard = deck.cards[Int.random(in: 0..<deck.cards.count)].rank.rawValue
                   continue
               }
    
            if theIndex == 0 {
                player1 = firstP
                player2 = secondP
                player3 = thirdP
                player4 = fourthP
                player5 = fithP
                player6 = sixthP
                print("\(firstP.description) starts")
                
            } else if theIndex ==  1{
                player1 = secondP
                player2 = thirdP
                player3 = fourthP
                player4 = fithP
                player5 = sixthP
                player6 = firstP
                print("\(secondP.description) starts")
            }
            else if theIndex == 2 {
                player1 = thirdP
                player2 = fourthP
                player3 = fithP
                player4 = sixthP
                player5 = firstP
                player6 = secondP
                print("\(thirdP.description) starts")
            }
            else if theIndex == 3 {
                player1 = fourthP
                player2 = fithP
                player3 = sixthP
                player4 = firstP
                player5 = secondP
                player6 = thirdP
                print("\(fourthP.description) starts")
            }
            else if theIndex == 4 {
                player1 = fithP
                player2 = sixthP
                player3 = firstP
                player4 = secondP
                player5 = thirdP
                player6 = fourthP
                print("\(fithP.description) starts")
            }
            else if theIndex == 5 {
                player1 = sixthP
                player2 = firstP
                player3 = secondP
                player4 = thirdP
                player5 = fourthP
                player6 = fithP
                print("\(sixthP.description) starts")
            }
            break
        }
    }
    
    func findCard(thePlayer: Hand, theCard: Card) {
        checkWin(who: thePlayer)
        for i in 0...thePlayer.cards.count - 1 {
            if thePlayer.cards[i].suit != theCard.suit {
                middle.cards.insert(thePlayer.cards[i], at: 0)
                thePlayer.cards.remove(at: i)
                break
            }
        }
    }
    
    func checkWin(who thePlayer: Hand){
        if thePlayer.cards.count == 0 {
            announceWinner(who: thePlayer)
            exit(0)
        }
    }
    
    func announceWinner(who thePlayer : Hand) {
        print(thePlayer.description + " is the winner")
    }
    
    // What's in the pot? (Mr. Gordon's code)
    func describeCards(in hand: Hand) {
        
        print("\n------- The player \(hand.description) has \(hand.cards.count) card(s). They are...")
        
        for card in hand.cards {
            print(card.simpleDescription())
        }
        
        print("------------------------------------------------------------------------")
        
    }
    
    func rounds(rounds: Int) {
        if rounds == 1 {
            print("It's 1st Round")
        } else if rounds == 2 {
            print("It's 2nd Round")
        } else if rounds == 3 {
            print("It's 3rd Round")
        } else {
            print("It's " + String(rounds) + "th Round")
        }
    }
    
    //Mr. Gordon's code
    // Let the user see what's happening before carrying on
    func waitForUserInput() {
        
        if interactiveMode {
            print("Press ENTER to continue...", terminator: "")
            readLine()
        }
        
    }
    
    
    
    
}
RollingStone(interactiveMode: true)
