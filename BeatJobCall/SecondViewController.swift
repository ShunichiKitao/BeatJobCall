//
//  SecondViewController.swift
//  BeatJobCall
//
//  Created by Shunichi Kitao on 2019/02/09.
//  Copyright © 2019年 Shunichi Kitao. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //callMusicの音声を再生する
        if let url = Bundle.main.url(forResource: "callMusic", withExtension: "mp4") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                //プレイヤーの作成失敗
                //その場合はプレイヤーをnilとする
                audioPlayer = nil
            }
            
            }else {
                //urlがnilなので再生できない
                fatalError("URL is nil")
            }
        }
        
    @IBAction func getCall(_ sender: Any) {
        
        audioPlayer?.stop()
        
    }
    
    

    @IBAction func deny(_ sender: Any) {
        
        //画面をViewContorolloerに遷移させる
        dismiss(animated: true, completion: nil)
        
        //callMusicの音声をストップさせる
        audioPlayer?.stop()


    }
    
    
}
