//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Ömer on 23.11.2023.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var hidenTimer = Timer()
    var score = 0
    var counter = 10
    var highScore = 0
    var kennyArray = [UIImageView]()
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        score = 0
        scoreLabel.text = "Score : \(score)"
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore : \(highScore)"
        }
        
        if let newScore = storedHighscore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore : \(highScore)"
        }
        
        
         
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
         
        
        let ges1 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        let ges2 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        let ges3 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        let ges4 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        let ges5 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        let ges6 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        let ges7 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        let ges8 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        let ges9 = UITapGestureRecognizer(target: self, action: #selector(tabArt))
        
        
        kenny1.addGestureRecognizer(ges1)
        kenny2.addGestureRecognizer(ges2)
        kenny3.addGestureRecognizer(ges3)
        kenny4.addGestureRecognizer(ges4)
        kenny5.addGestureRecognizer(ges5)
        kenny6.addGestureRecognizer(ges6)
        kenny7.addGestureRecognizer(ges7)
        kenny8.addGestureRecognizer(ges8)
        kenny9.addGestureRecognizer(ges9)
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        scoreLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(downTimer), userInfo: nil, repeats: true)
        
        hidenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidenKenny), userInfo: nil, repeats: true)
        
    }
    
    @objc func hidenKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let randomm = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[randomm].isHidden = false
    }
    

    @objc func tabArt(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
        
    @objc func downTimer(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hidenTimer.invalidate()
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            let alert = UIAlertController(title: "Finish", message: "Are you want to play again ?", preferredStyle: UIAlertController.Style.alert)
            
            let button = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score) "
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.downTimer), userInfo: nil, repeats: true)
                
                self.hidenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidenKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(button)
            alert.addAction(replay)
            
            self.present(alert, animated: true)
            
        }
        
        
    }

    
    
}

