import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var themeLabel: UILabel!
    
    let themes = [
        Theme(name: "haloween", emoji: ["🍎", "🎃", "👻", "😱", "🍬", "🍭", "🙀", "😈", "🦇"]),
        Theme(name: "holidays", emoji: ["☀️", "🍹", "✈️", "🛳", "⛱", "🎡", "🌄", "🛤", "🏝"]),
        Theme(name: "faces", emoji: ["👧🏻", "👩🏼‍🌾", "👨🏾‍🎓", "👨🏻‍🍳", "👨🏼‍💻", "🤴🏼", "🙆‍♀️", "🧖🏼‍♀️", "💑"]),
        Theme(name: "animals", emoji: ["🐶", "🐱", "🐭", "🐷", "🐧", "🦁", "🐥", "🐌", "🐒"]),
        Theme(name: "sport", emoji: ["⚽️", "🏂", "🛷", "🏏", "🏄🏻‍♀️", "🎖", "🏆", "🚵🏻‍♂️", "🧘‍♀️"]),
        Theme(name: "food", emoji: ["🍏", "🍐", "🍊", "🍋", "🥥", "🍖", "🍟", "🍔", "🥗"])]
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var emojiChoices = [String]()
    var currentThemeIndex = 0
    var emoji = [Card:String]()
    
    override func viewDidLoad() {
        setTheme()
        updateViewFromModel()
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game.reset()
        setTheme()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card is not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        //Update flipCount:
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"


        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    private func setTheme(){
        //Get a random theme
        var newThemeIndex = getRandomIndex(for: themes.count)

        // Ensure we dont get the same theme twice in a row
        while newThemeIndex == currentThemeIndex {
            newThemeIndex = getRandomIndex(for: themes.count)
        }
        currentThemeIndex = newThemeIndex
        emoji = [Card:String]()
        emojiChoices = themes[currentThemeIndex].emoji
        themeLabel.text = "Theme: \(themes[currentThemeIndex].name)"
    }

    private func getRandomIndex(for arrayCount: Int) -> Int {
        return Int(arc4random_uniform(UInt32(arrayCount)))
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}
    
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}















