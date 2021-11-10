//
//  ViewController.swift
//  EggTimer
//
//  Created by Mai Uchida on 2021/11/09.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timerNumber: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var softText: UIButton!
    @IBOutlet weak var mediumText: UIButton!
    @IBOutlet weak var hardText: UIButton!
    
    private let eggTimes = ["Soft": 240 , "Medium": 360, "Hard": 720]
    
    private var timer = Timer()
    private var secondRemaining = 0
    private var totalTime = 0
    private var player: AVAudioPlayer!
    var startTime:Date?
    let userDefault = UserDefaults.standard
    let START_TIME_KEY = "startTime"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTime = userDefault.object(forKey: START_TIME_KEY) as? Date

    }
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondRemaining = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
       
            
    }
    
    @objc  func timerAction() {
        if secondRemaining < totalTime{
            secondRemaining += 1
            totalTime -= 1
            let minutesLeft = Int(totalTime) / 60 % 60
            let secondsLeft = Int(totalTime) % 60
            timerNumber.text = "\(minutesLeft):\(secondsLeft)"
            
            progressBar.progress = Float(secondRemaining)/Float(totalTime)
        }else{
            timer.invalidate()
            titleLabel.text = "Done!"
            
            let url = Bundle.main.url(forResource: "Rooster-morning-call", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
        }
    
    func setStartTimer(date: Date?){
        startTime = date
        userDefault.set(date, forKey: START_TIME_KEY)
    }
    
    
}

