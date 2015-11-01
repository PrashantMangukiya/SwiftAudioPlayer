//
//  ViewController.swift
//  SwiftAudioPlayer
//
//  Created by Prashant on 01/11/15.
//  Copyright © 2015 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    // audio player object
    var audioPlayer = AVAudioPlayer()
    
    
    // play list file name and title
    var playList = [String]()
    var playListTitle = [String]()
    
    // total number of track
    var trackCount: Int = 0
    
    // currently playing track
    var currentTrack: Int = 0
    
    // is playing or not
    var isPlaying: Bool = false
    
    
    
    // outlet - track info label (e.g. Track 1/5)
    @IBOutlet var trackInfo: UILabel!
    
    // outlet - play duration label
    @IBOutlet var playDuration: UILabel!
    
    // outlet - track title label
    @IBOutlet var trackTitle: UILabel!
    
    
    
    // outlet & action - prev button
    @IBOutlet var prevButton: UIBarButtonItem!
    @IBAction func prevButtonAction(sender: UIBarButtonItem) {
        self.playPrevTrack()
    }
    
    // outlet & action - play button
    @IBOutlet var playButton: UIBarButtonItem!
    @IBAction func playButtonAction(sender: UIBarButtonItem) {
        self.playTrack()
    }
    
    // outlet & action - pause button
    @IBOutlet var pauseButton: UIBarButtonItem!
    @IBAction func pauseButtonAction(sender: UIBarButtonItem) {
        self.pauseTrack()
    }
    
    // outlet & action - forward button
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBAction func nextButtonAction(sender: UIBarButtonItem) {
        self.playNextTrack()
    }
    
    
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create/setup play list
        self.setupPlayList()
        
        // setup audio player
        self.setupAudioPlayer()
        
        // set button status
        self.setButtonStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Utility functions
    
    // create/setup playList
    private func setupPlayList() {
        
        // audio resource list
        self.playList = ["track-1","track-2","track-3","track-4","track-5"]
        
        // track title list
        self.playListTitle = ["Track title 1","Track title 2","Track title 3","Track title 4","Track title 5"]
        
        // total number of track
        self.trackCount = self.playList.count
        
        // currently playing track
        self.currentTrack = 1
        
        // set playing status
        self.isPlaying = false
    }
    
    // setup audio player
    private func setupAudioPlayer() {
    
        // coming soon...
    
    }
    
    // play current track
    private func playTrack() {
        
        // set play status
        self.isPlaying = true
    
        self.setButtonStatus()
    }

    // pause current track
    private func pauseTrack() {
        
        // set play status
        self.isPlaying = false
        
        self.setButtonStatus()
    }
    
    // play next track
    private func playNextTrack() {
        
        // pause current track
        self.pauseTrack()
        
        // change track
        if self.currentTrack < self.trackCount {
            self.currentTrack += 1
        }

        // play track
        self.playTrack()
    }
    
    // play prev track
    private func playPrevTrack() {

        // pause current track
        self.pauseTrack()
        
        // change track
        if self.currentTrack > 1 {
            self.currentTrack -= 1
        }

        // play track
        self.playTrack()
    }
    
    
    // enable / disable player button based on track
    private func setButtonStatus() {

        // set play/pause button based on playing status
        if isPlaying {
            self.playButton.enabled = false
            self.pauseButton.enabled = true
        }else {
            self.playButton.enabled = true
            self.pauseButton.enabled = false
        }
        
        // set prev/next button based on current track
        if self.currentTrack == 1  {
            self.prevButton.enabled = false
            if self.trackCount > 1 {
                self.nextButton.enabled = true
            }else{
                self.nextButton.enabled = false
            }
        }else if self.currentTrack == self.trackCount {
            self.prevButton.enabled = true
            self.nextButton.enabled = false
        }else {
            self.prevButton.enabled = true
            self.nextButton.enabled = true
        }
                
        // set track info
        self.trackInfo.text = "\(self.currentTrack) / \(self.trackCount) "
    
        // set track title
        self.trackTitle.text = self.playListTitle[self.currentTrack - 1]
    }
    
    
}

