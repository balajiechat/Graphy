//
//  GAVideoPlayerVC.swift
//  GraphyAssignment
//
//  Created Balaji S on 06/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit
import AVKit

protocol GAVideoPlayerViewProtocol: class {

    var presenter: GAVideoPlayerPresenterProtocol?  { get set }

    func playVideo(url: URL?)

}

class GAVideoPlayerVC: UIViewController {

	var presenter: GAVideoPlayerPresenterProtocol?

    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var seekSlider: UISlider!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    var customPlayerView: GACustomPlayerView!
    var avPlayerVC: AVPlayerViewController!

    var isPlaying: Bool {
        return avPlayerVC.player?.rate != 0 && avPlayerVC.player?.error == nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.playVideo()
        self.setSliderThumbTintColor(UIColor.white)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        self.controlView.addGestureRecognizer(gesture)
        self.showHideControlView()
    }

    deinit {
        print("deinit")
    }

    @IBAction func closeVideoPlayerVC() {
        self.presenter?.closeVideoPlayerVC()
    }

    @objc func tapped(_ sender: UITapGestureRecognizer) {
        self.showHideControlView()
    }

    func showHideControlView() {
        UIView.animate(withDuration: 0.3, animations: {
            let _ = self.controlView.subviews.map { $0.alpha = $0.alpha == 1 ? 0 : 1 }
        }) { (completed) in
            let _ = self.controlView.subviews.map { $0.isHidden = !$0.isHidden }
            if let first = self.controlView.subviews.first, !first.isHidden {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: {
                    UIView.animate(withDuration: 0.3, animations: {
                        let _ = self.controlView.subviews.map { $0.alpha = 0 }
                    }) { (completed) in
                        let _ = self.controlView.subviews.map { $0.isHidden = true }
                    }
                })
            }
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override var shouldAutorotate: Bool {
        return true
    }

}

extension GAVideoPlayerVC: GAVideoPlayerViewProtocol {

    func playVideo(url: URL?) {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            guard let url = url else { return }

            let player = AVPlayer(url: url)
            player.rate = 1
            self.avPlayerVC = AVPlayerViewController()
            self.avPlayerVC.player = player
            self.avPlayerVC.showsPlaybackControls = false
            self.avPlayerVC.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.avPlayerVC.view.translatesAutoresizingMaskIntoConstraints = false
            self.playerView.addSubview(self.avPlayerVC.view)
            NSLayoutConstraint.activate([
                self.avPlayerVC.view.topAnchor.constraint(equalTo: self.playerView.topAnchor),
                self.avPlayerVC.view.bottomAnchor.constraint(equalTo: self.playerView.bottomAnchor),
                self.avPlayerVC.view.leftAnchor.constraint(equalTo: self.playerView.leftAnchor),
                self.avPlayerVC.view.rightAnchor.constraint(equalTo: self.playerView.rightAnchor)
            ])

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0, execute: {
                self.seekSlider.minimumValue = 0
                guard let duration = player.currentItem?.duration else { return }
                let time : Float64 = CMTimeGetSeconds(duration)
                self.seekSlider.maximumValue = Float(time)
                self.seekSlider.isContinuous = true
                self.seekSlider.tintColor = UIColor.green
            })
        }
    }

}

extension GAVideoPlayerVC {

    fileprivate func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func setSliderThumbTintColor(_ color: UIColor) {
        let circleImage = makeCircleWith(size: CGSize(width: 10, height: 10), backgroundColor: color)
        seekSlider.setThumbImage(circleImage, for: .normal)
        seekSlider.setThumbImage(circleImage, for: .highlighted)
    }

    @IBAction func playPauseButtonTapAction(sender: UIButton) {
        if isPlaying {
            self.avPlayerVC.player?.pause()
        } else {
            self.avPlayerVC.player?.play()
        }
        self.playPauseButton.isSelected = !self.playPauseButton.isSelected
    }

    @IBAction func muteButtonTapAction(sender: UIButton) {
        self.avPlayerVC.player?.isMuted = self.avPlayerVC.player?.isMuted == true ? false : true
        self.muteButton.isSelected = !self.muteButton.isSelected
    }

    @IBAction func forwardButtonTapAction(sender: Any) {
        guard let player  = self.avPlayerVC.player, let duration = player.currentItem?.duration else { return }

        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = playerCurrentTime + 10

        if newTime < (CMTimeGetSeconds(duration) - 10) {
            let time = CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000)
            player.seek(to: time)
        }
    }

    @IBAction func rewindButtonTapAction(sender: Any) {
        guard let player  = self.avPlayerVC.player else { return }

        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = playerCurrentTime - 10

        if newTime < 0 {
            newTime = 0
        }
        let time = CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000)
        player.seek(to: time)
    }

    @IBAction func sliderValueChanged(sender: Any) {
        guard let player  = self.avPlayerVC.player else { return }

        let seconds : Int64 = Int64(seekSlider.value)
        let targetTime = CMTime(value: CMTimeValue(seconds * 1000), timescale: 1000)
        player.seek(to: targetTime)

        if !isPlaying {
            player.play()
        }
    }

}
