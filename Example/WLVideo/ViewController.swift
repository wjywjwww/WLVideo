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
    @IBOutlet weak var imageView: UIImageView!
    
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
                let videoEditer = WLVideoImageEditor(editType: .video, fileUrl: url)
                videoEditer.addWaterMark(with: UIImage(named: "sg_pa_water_local")!, localString: "上海中环 金环大厦", personTimeString: "吴加永 2020-11-11 22:22:22")
                videoEditer.assetReaderExport(completeHandler: { url in
                    let player = WLVideoPlayer(frame: self.view.bounds)
                    player.videoUrl = URL.init(fileURLWithPath: url)
                    self.view.addSubview(player)
                    player.play()
                })
            }else{
                let videoEditer = WLVideoImageEditor(editType: .image, fileUrl: url)
                videoEditer.addWaterMark(with: UIImage(named: "sg_pa_water_local")!, localString: "上海中环 金环大厦", personTimeString: "吴加永 2020-11-11 22:22:22")
                videoEditer.imageExport { (fileUrl, result) in
                    self.imageView.image = UIImage(contentsOfFile: fileUrl)
                }
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

