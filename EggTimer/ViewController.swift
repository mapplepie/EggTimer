//
//  ViewController.swift
//  EggTimer
//
//  Created by Mai Uchida on 2021/11/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var softText: UIButton!
    @IBOutlet weak var mediumText: UIButton!
    @IBOutlet weak var hardText: UIButton!
    
    private let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    private var timer = Timer()
    private var secondPassed = 0
    private var totalTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = UIFont(name: "Permanent_Marker", size: 40)
        softText.titleLabel?.font = UIFont(name: "Permanent_Marker", size: 30)
        mediumText.titleLabel?.font = UIFont(name: "Permanent_Marker", size: 30)
        hardText.titleLabel?.font = UIFont(name: "Permanent_Marker", size: 30)
        
    }
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            
    }
    
    @objc func timerAction() {
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed)/Float(totalTime)
        }else{
            timer.invalidate()
            titleLabel.text = "Done!"
        }
        }
    
    
}

