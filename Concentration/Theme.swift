import Foundation

struct Theme {
    var name: String
    var emoji: [String]
    
    init(name:String, emoji:[String]){
        self.name = name
        self.emoji = emoji
    }
}
