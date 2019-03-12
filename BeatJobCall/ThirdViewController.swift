//
//  ThirdViewController.swift
//  BeatJobCall
//
//  Created by Shunichi Kitao on 2019/02/09.
//  Copyright © 2019年 Shunichi Kitao. All rights reserved.
//

import UIKit
import AVFoundation

class ThirdViewController: UIViewController, AVAudioRecorderDelegate {
    
    
    
    var audioFile: String = ""
    
    //オーディオ関係の変数
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var isRecording = false
    var isPlaying = false
    
    //データ保存関係の変数
    var url : URL?
    var urlArray: [URL] = []
    let userDefaults = UserDefaults.standard
    var userDefaultsIsNil: Bool = true

    
    var count = 0
    
    var audioPlayer2 :AVAudioPlayer!

    @IBOutlet var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        //タイマーをスタートさせる
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountUp), userInfo: nil, repeats: true)

 
        buttonTapped()
        //jobCallの音声を再生する
        playjobCall()
        
    }
    
    func getURL() -> URL{
        //現在時刻をURL化するために必要な変数
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        //現在時刻をString型に変換して取得
        let now: String = "\(NSDate())"
        //nowをURL型に変換してurlに代入
        url = docsDirect.appendingPathComponent(now)
        //そのurlを配列に追加
        //urlArray.append(url!)
        //また、String型配列のaudioFileArrayに現在時刻(forKey用)を追加
        audioFile.append(now)
        
        return url!
    }
    
    
    
    func buttonTapped() {
        if !isRecording {
            
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try! session.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                
            ]
            
            audioRecorder = try! AVAudioRecorder(url: getURL(), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            isRecording = true
            
        }
    }

    
    //timeLabelに秒数を表示する
    @objc func timerCountUp(){
        
        count += 1
        timeLabel.text = String(count)
        
    }
    
    func playjobCall() {
        if let url = Bundle.main.url(forResource: "jobCall", withExtension: "m4a") {
            do {
                audioPlayer2 = try AVAudioPlayer (contentsOf: url)
                audioPlayer2?.play()
            } catch {
                //プレイヤー作成失敗
                //その場合はプレイヤーをnilとする
                audioPlayer2 = nil
            }
            
        } else {
            //urlがnilなので再生できない
            fatalError("URL is nil")
        }
    }
    
    @IBAction func deny2(_ sender: Any) {
                
        audioRecorder.stop()
        isRecording = false
      
        //urlの文字列が入ったstringsを"stringsArray"というForKeyで保存
        userDefaults.set(audioFile, forKey: "stringsFile")
        userDefaults.set(url, forKey: "urlFile")
        print(url)
        print(audioFile)
        userDefaultsIsNil = false
        //初期値がtrue(userDefaultsには何も入っていない)なので、falseにしたuserDefaultsIsNilを保存する
        userDefaults.set(userDefaultsIsNil, forKey: "nilFlag")

    
        //JobCallの音声をストップさせる
        audioPlayer2?.stop()

    }

}
