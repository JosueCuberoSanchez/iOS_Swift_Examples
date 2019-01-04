//
//  ViewController.swift
//  Concentration
//
//  Created by Josue on 12/19/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var message: String? {
        didSet {
            message2 = message ?? "jue"
        }
    }
    var message2: String?
    
    private lazy var game: Concentration = Concentration(numberOfPairs: numberOfPairsOfCards)
    
    @IBOutlet private var cardButtons:  [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var picker: UIPickerView!
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private var emojiChoices = [String]()
    private var emoji = [Card:String]()
    private var pickerData = [String]()
    private var pickerThemes = [String:[String]]()

    
    required init?(coder aDecoder: NSCoder){
        pickerThemes["Halloween"] = ["🎃","👻","💀","👽","🤡","👹"]
        pickerThemes["Laugh"] = ["😆","😂","🤣","😁","😃","😅"]
        // able to add more themes on one line of code
        
        for (theme, _) in pickerThemes {
            pickerData += [theme]
        }
        
        emojiChoices = pickerThemes["Halloween"]!
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return pickerData.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return pickerData[row] }

    @IBAction func touchCard(_ sender: UIButton) {
        
        game.flipCount += 1 // this will notify trigger didSet
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in cards array")
        }
        
    }
    
    @IBAction func resetGame(_ sender: UIButton) { reset() }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Count: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
 
    private func emoji(for card: Card) -> String {
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            
            let randomIndex = emojiChoices.count.arc4random
            emoji[card] = emojiChoices.remove(at: randomIndex)
            
        }
        
        return emoji[card] ?? "?"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reset()
        emojiChoices = pickerThemes[(pickerData[row])]!
        emoji.removeAll()
    }
    
    private func reset(){
        game.reset()
        flipCountLabel.text = "Count: \(game.flipCount)"
        updateViewFromModel()
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
