//
//  ViewController.swift
//  DrawingExamples
//
//  Created by Josue on 12/26/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var deck = CardDeck()
    
    @IBOutlet private var cardViews: [PlayingCardView]!
    
    private var faceUpCardViews: [PlayingCardView] {
        return cardViews.filter({ $0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0) && $0.alpha == 1 })
    }
    
    private var faceUpCarViewsMatch: Bool {
        return
            faceUpCardViews.count == 2 &&
            faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
            faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var cardBehavior = CardBehavior(in: animator)
    var lastChosenCardView: PlayingCardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cards = [PlayingCard]()
        for _ in 0 ..< cardViews.count {
            if let card = deck.draw() {
                print("\(card)")
                cards += [card]
            }
        }
        for cardView in cardViews {
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.changeLabel()
            
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            
            cardBehavior.addItem(cardView)
        }
        
    }
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer){
        switch recognizer.state {
        case .ended:
            if let view = recognizer.view as? PlayingCardView, faceUpCardViews.count < 2 {
                lastChosenCardView = view
                cardBehavior.removeItem(view)
                UIView.transition(
                    with: view,
                    duration: 0.6,
                    options: [.transitionFlipFromRight],
                    animations: { view.isFaceUp = !view.isFaceUp },
                    completion: { finished in
                        let cardsToAnimate = self.faceUpCardViews
                        if self.faceUpCarViewsMatch {
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.6,
                                delay: 0.2,
                                options: [],
                                animations: {
                                    cardsToAnimate.forEach {
                                        $0.transform = CGAffineTransform.identity.scaledBy(
                                            x: 3.0,
                                            y: 3.0
                                        )
                                    }
                                },
                                completion: {
                                    position in
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.6,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            cardsToAnimate.forEach {
                                                $0.transform = CGAffineTransform.identity.scaledBy(
                                                    x: 0.1,
                                                    y: 0.1
                                                )
                                                $0.alpha = 0
                                            }
                                        },
                                        completion: {
                                            position in
                                            cardsToAnimate.forEach {
                                                $0.isHidden = true
                                                $0.alpha = 1 /// clean up
                                                $0.transform = .identity
                                            }
                                        }
                                    )
                                }
                            )
                        } else if cardsToAnimate.count == 2 {
                            if view == self.lastChosenCardView {
                                cardsToAnimate.forEach {
                                    cardView in
                                    UIView.transition(
                                        with: cardView,
                                        duration: 0.6,
                                        options: [.transitionFlipFromLeft],
                                        animations: { cardView.isFaceUp = false },
                                        completion: { finished in
                                            self.cardBehavior.addItem(view)
                                    }
                                    )
                                }
                            }
                        } else {
                            if !view.isFaceUp {
                                self.cardBehavior.addItem(view)
                            }
                        }
                    }
                )
            }
        default:
            break
        }
    }


}

extension CGFloat {
    var arc4random: CGFloat {
        if self > 0 {
            return CGFloat(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return CGFloat(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
