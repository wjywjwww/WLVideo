//
//  ViewController.swift
//  WLVideo
//
//  Created by w704444178@qq.com on 01/07/2020.
//  Copyright (c) 2020 w704444178@qq.com. All rights reserved.
//

import UIKit
import WLVideo

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textLayer = CATextLayer()
        
        textLayer.foregroundColor = UIColor.red.cgColor
        textLayer.string = "上海市浦东新区政立路485号"
        textLayer.fontSize = 15
        textLayer.alignmentMode = "center"
        textLayer.position = CGPoint(x: 100, y: 100)
        textLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        textLayer.contentsScale = 3
        self.view.layer.addSublayer(textLayer)
    }

    @IBAction func buttonClick(_ sender: Any) {
        let vc = WLCameraController()
        vc.type = .video
        vc.modalPresentationStyle = .fullScreen
        vc.completeBlock = { url, type in
            if type == .video {
                let videoEditer = WLVideoEditor.init(videoUrl: URL.init(fileURLWithPath: url))
                videoEditer.addWaterMark(markString: "上海市浦东新区政立路485号")
                XCVideoEditManager.default()?.waterText = "上海市浦东新区政立路485号"
                XCVideoEditManager.default()?.startEditVideo(URL(fileURLWithPath: url), progress: { (_) in
                    
                }, success: { (result) in
                    DispatchQueue.main.async {
                        let player = WLVideoPlayer(frame: self.view.bounds)
                        player.videoUrl = URL.init(fileURLWithPath: result ?? "")
                        self.view.addSubview(player)
                        player.play()
                    }
                }, failure: { (error) in
                    
                })
//                videoEditer.assetReaderExport(completeHandler: { url in
//                    let player = WLVideoPlayer(frame: self.view.bounds)
//                    player.videoUrl = URL.init(fileURLWithPath: url)
//                    self.view.addSubview(player)
//                    player.play()
//                })
            }
               }
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

