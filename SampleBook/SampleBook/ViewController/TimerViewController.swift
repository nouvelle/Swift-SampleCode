//
//  TimerViewController.swift
//  SampleBook
//
//  Created by eriko on 2022/03/27.
//

import UIKit
import AudioToolbox

class TimerViewController: UIViewController {

    @IBOutlet weak var dispLabel: UILabel!
    
    private var timer: Timer?
    private var currentTime: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tenSecButtonAction(_ sender: Any) {
        start(sec: 10)
    }
    @IBAction func oneMinButtonAction(_ sender: Any) {
        start(sec: 60)
    }
    @IBAction func threeMinButtonAction(_ sender: Any) {
        start(sec: 180)
    }
    @IBAction func stopButtonAction(_ sender: Any) {
        timer?.invalidate()
        dispLabel.text = "停止中"
    }
    
    private func start(sec: Int) {
        currentTime = sec
        dispLabel.text = "残り時間 \(currentTime)秒"
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,  // タイマーが完了した時の通知先インスタンス
            selector: #selector(self.update),  // タイマーが完了した時の通知先メソッド
            userInfo: nil,  // タイマーに付与する情報
            repeats: true
        )
    }
    
    @objc private func update() {
        currentTime -= 1
        dispLabel.text = "残り時間 \(currentTime)秒"
        if currentTime == 0 {
            timer?.invalidate()
            let soundId: SystemSoundID = 1005
            AudioServicesPlayAlertSound(soundId)  // システム音を鳴らす
        }
    }

}
