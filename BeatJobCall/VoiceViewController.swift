//
//  VoiceViewController.swift
//  BeatJobCall
//
//  Created by Shunichi Kitao on 2019/02/12.
//  Copyright © 2019年 Shunichi Kitao. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var audioFile: String = ""
    
    //データ保存関係の変数
    var url : URL?
    var urlArray: [URL] = []
    let userDefaults = UserDefaults.standard
    var userDefaultsIsNil: Bool = true
    
    //オーディオ関係の変数
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var isRecording = false
    var isPlaying = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell!.textLabel?.text = "新規録音"
        
        return cell!
    }
    
    //userDefaults.set(audioFile, forKey: "stringsFile")
    //userDefaults.set(url, forKey: "urlFile")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.object(forKey: "stringsFile") != nil {
            
            audioFile = UserDefaults.standard.object(forKey: "stringsFile") as! String
            
            print(audioFile)
            
        }
        
        //URLの方をUserDefalutsで読み込み。それから文字列とファイルで再生
        if UserDefaults.standard.object(forKey: "urlFile") != nil {
            
            url = UserDefaults.standard.object(forKey: "urlFile") as! URL?
            print(url!)
            
            //urlArray.append(url!)
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isPlaying {
            audioPlayer.delegate = self
            audioPlayer.play()
            
            isPlaying = true
            
        }else{
            
            audioPlayer.stop()
            isPlaying = false
        }
    }
    
}
