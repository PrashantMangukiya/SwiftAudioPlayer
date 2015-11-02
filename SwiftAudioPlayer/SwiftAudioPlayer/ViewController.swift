//
//  ViewController.swift
//  SwiftAudioPlayer
//
//  Created by Prashant on 01/11/15.
//  Copyright © 2015 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate {

    // audio player object
    var audioPlayer = AVAudioPlayer()
    
    
    // play list file and title list
    var playListFiles = [String]()
    var playListTitles = [String]()
    
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
        
        // setup play list
        self.setupPlayList()
        
        // setup audio player
        self.setupAudioPlayer()
        
        // set button status
        self.setButtonStatus()
        
        // play track
        self.playTrack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
    // MARK: - AVAudio player delegate functions.
    
    // set status false and set button  when audio finished.
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
        // set playing off
        self.isPlaying = false
        
        self.setButtonStatus()
    }
    
    
    
    
    // MARK: - Utility functions
    
    // setup playList
    private func setupPlayList() {
        
        // audio resource file list
        self.playListFiles = ["forest-bright-01","jungle-01","swamp-01","forest-bright-01","jungle-01"]
        
        // track title list
        self.playListTitles = ["1 - Forest Bright", "2 - Jungle", "3 - Swamp", "4 - Forest Bright", "5 - Jungle"]
        
        // total number of track
        self.trackCount = self.playListFiles.count
        
        // set current track
        self.currentTrack = 1
        
        // set playing status
        self.isPlaying = false
    }
    
    
    // setup audio player
    private func setupAudioPlayer() {
    
        // choose file from play list
        let fileURL:NSURL =  NSBundle.mainBundle().URLForResource(self.playListFiles[self.currentTrack-1], withExtension: "mp3")!
        
        do {
            // create audio player with given file url
            self.audioPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
            
            // set audio player delegate
            self.audioPlayer.delegate = self
            
            // set default volume level
            self.audioPlayer.volume = 0.7
            
            // make player ready (i.e. preload buffer)
            self.audioPlayer.prepareToPlay()
            
        } catch let error as NSError {
            // print error in friendly way
            print(error.localizedDescription)
        }
        
    }
    
    // play current track
    private func playTrack() {
        
        // set play status
        self.isPlaying = true
        
        // play currently loaded track
        self.audioPlayer.play()
        
        self.setButtonStatus()
    }

    // pause current track
    private func pauseTrack() {
        
        // set play status
        self.isPlaying = false
        
        // play currently loaded track
        self.audioPlayer.pause()
        
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

        // stop player if currently playing
        if self.audioPlayer.playing {
            self.audioPlayer.stop()
        }
        
        // setup player for updated track
        self.setupAudioPlayer()
        
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
        
        // stop player if currently playing
        if self.audioPlayer.playing {
            self.audioPlayer.stop()
        }
        
        // setup player for updated track
        self.setupAudioPlayer()
        
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
        self.trackInfo.text = "Track \(self.currentTrack) / \(self.trackCount)"
    
        // set track title
        self.trackTitle.text = self.playListTitles[self.currentTrack - 1]
    }
    
    
}

