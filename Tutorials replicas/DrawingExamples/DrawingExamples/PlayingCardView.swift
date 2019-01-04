//
//  PlayingCardvViewViewController.swift
//  DrawingExamples
//
//  Created by Josue on 12/26/18.
//  Copyright © 2018 Josue. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    @IBOutlet weak var myLabel: UILabel!
    
    var rank = 5 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var suit = "❤️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp = true { didSet { setNeedsDisplay(); setNeedsLayout(); changeLabel(); } }
    
    private var cornerString: NSAttributedString { return centeredAttributedString("\(rankString)\n\(suit)", cornerFontSize) }
    private var cornerRadius: CGFloat { return bounds.size.height * Constants.cornerRadiusToBoundsHeight }
    private var cornerOffset: CGFloat { return cornerRadius * Constants.cornerOffsetToCornerRadius }
    private var cornerFontSize: CGFloat { return bounds.size.height * Constants.cornerFontSizeToBoundsHeight }
    
    private var rankString: String {
        switch rank {
        case 1:
            return "A"
        case 2 ... 10:
            return String(rank)
        case 11:
            return "J"
        case 12:
            return "Q"
        case 13:
            return "K"
        default:
            return "?"
        }
    }
    
    func changeLabel() {
        if self.isFaceUp {
            self.myLabel.text = "\(rank) \(suit)"
        } else {
            self.myLabel.text = "Face down"
        }
    }
    
    override func draw(_ rect: CGRect) {
        /*let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        path.lineWidth = 5.0
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.stroke()
        path.fill()*/
        
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
    private func centeredAttributedString(_ string: String, _ fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, .font: font])
    }
    
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth), dy: (height - newHeight)/2)
    }
}
