//
//  ViewController.swift
//  Set
//
//  Created by Josue on 12/20/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var buttons: [UIButton] = []
    private lazy var game = Set()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Style each button depending on the color, texture and title
        for index in 0 ..< game.numberOfVisibleCards {
            setStyleOfButtonWithIndex(index)
        }
        
    }
    
    /**
     Styles the view buttons according to their color, texture and title.
     
     - Parameter index: the index of the button on the UIButtons array and cards array.
     */
    func setStyleOfButtonWithIndex(_ index: Int) {
        
        var attribute: [NSAttributedString.Key: Any]
        
        switch game.cards[index].color {
            case .green:
                switch game.cards[index].texture {
                    case .filled:
                        attribute = FigureAttributes.fullGreenFigureAttributes
                    case .degradated:
                        attribute = FigureAttributes.degradedGreenFigureAttributes
                    case .bordered:
                        attribute = FigureAttributes.greenBorderedFigureAttributes
                }
            case .purple:
                switch game.cards[index].texture {
                    case .filled:
                        attribute = FigureAttributes.fullPurpleFigureAttributes
                    case .degradated:
                        attribute = FigureAttributes.degradedPurpleFigureAttributes
                    case .bordered:
                        attribute = FigureAttributes.purpleBorderedFigureAttributes
                }
        case .yellow:
            switch game.cards[index].texture {
                case .filled:
                    attribute = FigureAttributes.fullYellowFigureAttributes
                case .degradated:
                    attribute = FigureAttributes.degradedYellowFigureAttributes
                case .bordered:
                    attribute = FigureAttributes.yellowBorderedFigureAttributes
            }
        }
        
        buttons[index].show(game.cards[index].title, attribute)
    }

    /**
     Manages the clicking of a button.
     
     - Parameter sender: The button that is calling the method.
     */
    @IBAction func onButtonClick(_ sender: UIButton) {
        
        guard let cardNumber = buttons.index(of: sender) else {
            return
        }
        
        guard game.cards[cardNumber].inField else {
            return
        }
        
        guard (!game.cards[cardNumber].selected && game.numberOfSelectedCards < 3) || (game.cards[cardNumber].selected) else {
            showToast(message: "Only 3 cards must be selected")
            return
        }
        
        /// if user is diselecting a card
        if(game.cards[cardNumber].selected) {
            
            sender.diselect()
            game.diselectCardWithIndex(cardNumber)
            
        } else {
            /// if user is selecting a diselected card

            sender.select()
            game.selectCardWithIndex(cardNumber)
            
            if game.numberOfSelectedCards == 3 {
                checkForSet()
            }
        }
    }
    
    /**
     Adds 3 more cards to the table.
     
     - Paramerer sender: The button calling the method.
     */
    @IBAction func dealMoreCards(_ sender: UIButton) {
        
        
        for index in game.numberOfVisibleCards ..< game.numberOfVisibleCards+3 {
            setStyleOfButtonWithIndex(index)
        }
        
        game.dealMoreCards()
        
        if game.numberOfVisibleCards >= 24 {
            
            sender.isEnabled = false
            
        }
        
    }
    
    /**
     Checks if the user selection is a valid set.
     
     - Returns: True if it is a valid set, false if not.
     */
    func checkForSet() {
        if game.checkForSet() {
            hideButtons()
            game.removeCards()
            showToast(message: "Set found!")
        } else {
            showToast(message: "That is not a valid set")
        }
    }
    
    /**
     Hides the selected cards in case they were a set.
    */
    func hideButtons() {
        for index in 0 ..< 3 {
            print(index)
            let button = buttons[game.selectedIndices[index]]
            button.hide()
        }
    }
    
}

extension UIButton {
    
    /**
     Extension for UIButton that shows a button on the screen.
     */
    func show(_ title: String,_ attribute: [NSAttributedString.Key: Any]){
        self.setAttributedTitle(NSAttributedString(string: title, attributes: attribute), for: [])
        self.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    /**
     Extension for UIButton that hides a button on the screen.
    */
    func hide(){
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.setAttributedTitle(NSAttributedString(string: "", attributes: FigureAttributes.fullGreenFigureAttributes), for: [])
        self.layer.borderWidth = 0
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    /**
     Extension for UIButton that selects a button on the screen.
     */
    func select(){
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    /**
     Extension for UIButton that diselects a button on the screen.
     */
    func diselect(){
        self.layer.borderWidth = 0
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

extension UIViewController {
    
    /**
     Extension for UIViewController that simulates a toast message on the screen.
     
     - Parameter message: The message to be printed on the screen.
     */
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 200, y: self.view.frame.size.height-100, width: 400, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
} }
