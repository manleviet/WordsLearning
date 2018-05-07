//
//  ViewController.swift
//  Test
//
//  Created by Lê Viết Mẫn on 6/20/16.
//  Copyright © 2016 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var imageView: NSButton!
    @IBOutlet weak var wordView: NSView!
    
    let words = Words()
    
    let speechSynth = NSSpeechSynthesizer()
    
    var isBegin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        words.loadData()
    }

    func showCurrentWord()
    {
        if let image = words.currentImage {
            imageView.image = image
            imageView.alternateImage = image
        }
        
        wordView.subviews.forEach { $0.removeFromSuperview() }
        
        let newWordView = visualize(words.currentWord.uppercased(), superview: wordView)
        wordView.addSubview(newWordView)
        
        speechSynth.startSpeaking(words.currentWord)
    }
    
    @IBAction func nextWord(_ sender: AnyObject) {
        if isBegin {
            speechSynth.stopSpeaking()
        
            words.nextWord()
        } else {
            isBegin = true
        }
        
        showCurrentWord()
    }
    
    @IBAction func speakingAgain(_ sender: NSButton) {
        imageView.highlight(false)
        speechSynth.stopSpeaking()
        speechSynth.startSpeaking(words.currentWord)
    }
}

