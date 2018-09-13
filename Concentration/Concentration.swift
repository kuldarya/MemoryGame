import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
    }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
  
    private(set) var flipCount = 0
    private(set) var score = 0
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if cards[index].isMatched == false {
            flipCount += 1
            
            //if a card is faced up and doesn't match the one you already picked
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                calculateScore(with: -1)
                
                //if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    calculateScore(with: 2)
                }
            }
                cards[index].isFaceUp = true
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        //Create the specified pair of cards
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        self.shuffle()
    }
    
    private func shuffle(){
        for _ in 1...cards.count {
            cards.sort {
                (_, _) in arc4random() < arc4random()
            }
        }
    }
    
    func reset(){
        flipCount = 0
        score = 0
        for index in 0..<cards.count {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    private func calculateScore(with number: Int){
        let result = score + number
        score = result < 0 ? 0 : result
        }
    }

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}





























