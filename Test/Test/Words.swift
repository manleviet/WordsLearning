//
//  Words.swift
//  Test
//
//  Created by Lê Viết Mẫn on 6/20/16.
//  Copyright © 2016 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class Words {
    private var listWord : [String] = []
    private var currentIndex : Int = 0
    
    var currentWord : String {
        get {
            return listWord[currentIndex]
        }
    }
    
    var currentImage : NSImage? {
        get {
            return NSImage(named: listWord[currentIndex])
        }
    }
    
    func nextWord() {
        currentIndex += 1;
        
        if currentIndex >= listWord.count {
            currentIndex = 0
        }
    }
    
    func loadData() {
        listWord = NSArray(contentsOf: Bundle.main().urlForResource("Words", withExtension: "plist")!)! as! [String]
    }
}
