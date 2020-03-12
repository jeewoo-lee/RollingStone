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
    
    //creating the 6 users
    var player1 : Hand
    var player2 : Hand
    var player3 : Hand
    var player4 : Hand
    var player5 : Hand
    var player6 : Hand

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
        var possibleNumber = 0
        while true{
            print("Please Enter the number of player you want to play with")
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

        }
        else if possibleNumber == 5 {
            print("Please Enter the name of five players you want to play with")
            player1 = Hand(description: readLine()!)
            player2 = Hand(description: readLine()!)
            player3 = Hand(description: readLine()!)
            player4 = Hand(description: readLine()!)
            player5 = Hand(description: readLine()!)
            player6 = Hand(description: "none")

         }
        else if possibleNumber == 6 {
            print("Please Enter the name of six players you want to play with")
            player1 = Hand(description: readLine()!)
            player2 = Hand(description: readLine()!)
            player3 = Hand(description: readLine()!)
            player4 = Hand(description: readLine()!)
            player5 = Hand(description: readLine()!)
            player6 = Hand(description: readLine()!)

        } else{
        print("restart and type number between 4-6")
        }
    }
    

}
RollingStone()
