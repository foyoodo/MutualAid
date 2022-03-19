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

    var detailData: MATopListDetailModel

    init(_ detailData: MATopListDetailModel) {
        self.detailData = detailData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let playerController: AVPlayerViewController = {
        let playerController = AVPlayerViewController()
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

        let url = URL.init(string: self.detailData.playerUrl)
        playerController.player = AVPlayer.init(url: url!)

        let link = URL.init(string: self.detailData.webPageUrl)
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
