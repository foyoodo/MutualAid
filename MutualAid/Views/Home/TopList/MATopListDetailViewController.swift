//
//  MATopListDetailViewController.swift
//  MutualAid
//
//  Created by foyoodo on 2022/3/19.
//

import UIKit
import AVKit
import WebKit
import SnapKit

class MATopListDetailViewController: UIViewController {

    let playerController: AVPlayerViewController = {
        let playerController = AVPlayerViewController()
        let url = URL.init(string: "https://www.he-grace.com/files/jjxy_img/jjxy_cover/video/viedoUrl/1.mp4")
        playerController.player = AVPlayer.init(url: url!)
        return playerController
    }()

    let segmentView: MATopListDetailSegmentView = {
        let segmentView = MATopListDetailSegmentView()
        return segmentView
    }()

    let webView: WKWebView = {
        let webView = WKWebView()
        webView.scrollView.showsVerticalScrollIndicator = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.addChild(playerController)
        self.view.addSubview(playerController.view)
        playerController.didMove(toParent: self)
        playerController.view.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }

        self.view.addSubview(segmentView)
        segmentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(playerController.view.snp.bottom)
        }

        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
        }

        let link = URL.init(string: "https://www.he-grace.com/cabinet/app/jjxy/videoMessage?videoType=24")
        webView.load(URLRequest.init(url: link!))
    }

    override func viewDidLayoutSubviews() {
        playerController.view.snp.updateConstraints { make in
            make.height.equalTo(playerController.view.bounds.width * 0.56272)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        playerController.player?.play()
    }

}
