//
//  ViewController.swift
//  Pelmanism
//
//  Created by shogo on 5/30/16.
//  Copyright © 2016 shogo.okumura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card01: UIButton!
    @IBOutlet weak var card02: UIButton!
    @IBOutlet weak var card03: UIButton!
    @IBOutlet weak var card04: UIButton!
    @IBOutlet weak var card05: UIButton!
    @IBOutlet weak var card06: UIButton!
    @IBOutlet weak var card07: UIButton!
    @IBOutlet weak var card08: UIButton!
    @IBOutlet weak var card09: UIButton!
    @IBOutlet weak var card10: UIButton!
    @IBOutlet weak var card11: UIButton!
    @IBOutlet weak var card12: UIButton!
    @IBOutlet weak var card13: UIButton!
    @IBOutlet weak var card14: UIButton!
    @IBOutlet weak var card15: UIButton!
    @IBOutlet weak var card16: UIButton!
    @IBOutlet weak var card17: UIButton!
    @IBOutlet weak var card18: UIButton!
    @IBOutlet weak var card19: UIButton!
    @IBOutlet weak var card20: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!

    var allCards:[UIButton] = []
    var turn:Int = 1
    var left:Int = 20
    
    var wordList:[String] = []
    var randomWordList:[String] = []
    var turnedOverCardNums:[Int] = []

    @IBAction func card01Touched(sender: AnyObject) {
        turnOverCard(card01, num: 0)
    }

    @IBAction func card02Touched(sender: AnyObject) {
        turnOverCard(card02, num: 1)
    }
    
    @IBAction func card03Touched(sender: AnyObject) {
        turnOverCard(card03, num: 2)
    }
    
    @IBAction func card04Touched(sender: AnyObject) {
        turnOverCard(card04, num: 3)
    }
    
    @IBAction func card05Touched(sender: AnyObject) {
        turnOverCard(card05, num: 4)
    }
    
    @IBAction func card06Touched(sender: AnyObject) {
        turnOverCard(card06, num: 5)
    }
    
    @IBAction func card07Touched(sender: AnyObject) {
        turnOverCard(card07, num: 6)
    }
    
    @IBAction func card08Touched(sender: AnyObject) {
        turnOverCard(card08, num: 7)
    }
    
    @IBAction func card09Touched(sender: AnyObject) {
        turnOverCard(card09, num: 8)
    }
    
    @IBAction func card10Touched(sender: AnyObject) {
        turnOverCard(card10, num: 9)
    }
    
    @IBAction func card11Touched(sender: AnyObject) {
        turnOverCard(card11, num: 10)
    }
    
    @IBAction func card12Touched(sender: AnyObject) {
        turnOverCard(card12, num: 11)
    }
    
    @IBAction func card13Touched(sender: AnyObject) {
        turnOverCard(card13, num: 12)
    }
    
    @IBAction func card14Touched(sender: AnyObject) {
        turnOverCard(card14, num: 13)
    }
    
    @IBAction func card15Touched(sender: AnyObject) {
        turnOverCard(card15, num: 14)
    }
    
    @IBAction func card16Touched(sender: AnyObject) {
        turnOverCard(card16, num: 15)
    }
    
    @IBAction func card17Touched(sender: AnyObject) {
        turnOverCard(card17, num: 16)
    }
    
    @IBAction func card18Touched(sender: AnyObject) {
        turnOverCard(card18, num: 17)
    }
    
    @IBAction func card19Touched(sender: AnyObject) {
        turnOverCard(card19, num: 18)
    }
    
    @IBAction func card20Touched(sender: AnyObject) {
        turnOverCard(card20, num: 19)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("sample", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)!
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! NSDictionary
            wordList = json["medium"]! as! [String]
        } catch let err as NSError {
            print(err.localizedDescription)
        }
        
        allCards = [card01, card02, card03, card04, card05, card06, card07, card08, card09, card10, card11, card12, card13, card14, card15, card16, card17, card18, card19, card20]

        turnLabel.text = String(turn)
        leftLabel.text = String(left)
        wordLabel.textAlignment = NSTextAlignment.Center
        wordLabel.font = UIFont(name: "ChalkboardSE-Regular", size:20)
        wordLabel.adjustsFontSizeToFitWidth = true
        wordLabel.layer.borderColor = UIColor.blackColor().CGColor
        wordLabel.layer.borderWidth = 0.5
        wordLabel.layer.cornerRadius = 5
        wordLabel.text = " "

        for _ in 0...1 {
            for word in wordList {
            randomWordList.append(word)
            }
        }
        
        shuffleWordList()
        
        for card in allCards {
            card.layer.borderColor = UIColor.blackColor().CGColor
            card.layer.borderWidth = 0.5
            card.layer.cornerRadius = 5
            card.titleLabel!.textAlignment = NSTextAlignment.Center
            close(card)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func close(card:UIButton) {
        card.backgroundColor = UIColor.purpleColor()
        card.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        card.setTitle("?", forState: .Normal)
        card.titleLabel!.font = UIFont(name: "ChalkboardSE-Regular", size:30)
        card.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    func open(card:UIButton) {
        card.backgroundColor = UIColor.clearColor()
        card.setTitleColor(UIColor.blueColor(), forState: .Normal)
        card.titleLabel!.font = UIFont(name: "ChalkboardSE-Regular", size:15)
        card.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    func turnOverCard(card:UIButton, num:Int) {
        if card.titleLabel?.text == "?" && turnedOverCardNums.count < 2 {
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 20, options:[], animations: {
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                self.open(card)
                card.setTitle(self.randomWordList[num], forState: .Normal)
                self.wordLabel.text = self.randomWordList[num]
                self.turnedOverCardNums.append(num)
            }, completion: { _ in
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                if self.turnedOverCardNums.count == 2 {
                    self.removeOrClose()
                }
            })
        }
    }
 
    func removeOrClose() {
        if randomWordList[turnedOverCardNums[0]] == randomWordList[turnedOverCardNums[1]] {
            self.hideCard(self.turnedOverCardNums[0])
            self.hideCard(self.turnedOverCardNums[1])
            self.left -= 2
            self.leftLabel.text = String(self.left)
            if left == 0 {
                restart()
            }
        } else {
            self.close(self.allCards[self.turnedOverCardNums[0]])
            self.close(self.allCards[self.turnedOverCardNums[1]])
            self.turn += 1
            self.turnLabel.text = String(self.turn)
        }
        self.wordLabel.text = " "
        turnedOverCardNums = []
    }
    
    func hideCard(num:Int) {
        self.allCards[num].hidden = true
    }

    func restart() {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 20, options:[], animations: {
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            self.left = 20
            self.leftLabel.text = String(self.left)
            self.turn = 1
            self.turnLabel.text = String(self.turn)
            self.wordLabel.text = " "
            self.shuffleWordList()
            for card in self.allCards {
                self.close(card)
                card.hidden = false
            }
            }, completion: { _ in
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
        })

    }

    func shuffleWordList() {
        var j = randomWordList.count - 1
        while j > 0 {
            let k = Int(arc4random_uniform(UInt32(j + 1))) // 0 <= k <= j
            guard j != k else { continue }
            swap(&randomWordList[k], &randomWordList[j])
            j -= 1
        }
    }
}

