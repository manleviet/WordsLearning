//
//  WordVisualization.swift
//  Test
//
//  Created by Lê Viết Mẫn on 6/22/16.
//  Copyright © 2016 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

private enum Theme {
    enum Color {
        static let border = NSColor(red: CGFloat(184/255.0), green: 201/255.0, blue: 238/255.0, alpha: 1)
        static let shade = NSColor(red: CGFloat(227/255.0), green: 234/255.0, blue: 249/255.0, alpha: 1)
        static let highlight = NSColor(red: CGFloat(14/255.0), green: 114/255.0, blue: 199/255.0, alpha: 1)
    }
    enum Font {
        static let codeVoice = NSFont(name: "Menlo-Regular", size: 48)!
    }
}

private struct StyledString {
    let string: String
    let isWaitingTyping: Bool
}

private extension NSTextField {
    convenience init(styledString: StyledString) {
        self.init()
        stringValue = styledString.string
        alignment = .center
        font = Theme.Font.codeVoice // dung switch de ap font cho dung
        textColor = NSColor.black()
        backgroundColor = NSColor.white()
    }
}

public func visualize(_ str: String, superview: NSView) -> NSView {
    return _visualize(str, range: nil, superview: superview)
}

public func visualize(_ str: String, index: String.Index, superview: NSView) -> NSView {
    let range = index..<str.index(after:index)
    return _visualize(str, range: range, superview: superview)
}

public func visualize(_ str: String, range: Range<String.Index>, superview: NSView) -> NSView {
    return _visualize(str, range: range, superview: superview)
}

private func _visualize(_ str: String, range: Range<String.Index>?, superview: NSView) -> NSView {
    let stringIndices = str.characters.indices
    
    let styledCharacters = zip(stringIndices, str.characters).map { (characterIndex, char) -> StyledString in
        let isWaitingTyping: Bool
        if let range = range where range.contains(characterIndex) {
            isWaitingTyping = true
        } else {
            isWaitingTyping = false
        }
        return StyledString(string: String(char), isWaitingTyping: isWaitingTyping)
    }
    
    let characterLabels = styledCharacters.map { NSTextField(styledString: $0) }
    
    // phai tinh toan lai cac gia tri nay cho phu hop
    // neu so luong ky tu
    
    let stackView = NSStackView(frame: CGRect(x: 0, y: 0, width: 60 * characterLabels.count, height: 80))
    stackView.distribution = .fillEqually
    stackView.spacing = 0
    characterLabels.forEach(stackView.addArrangedSubview)
    
    let x = (NSWidth(superview.bounds) - NSWidth((stackView.frame)))/2
    let y = (NSHeight(superview.bounds) - NSHeight(stackView.frame))/2
    stackView.setFrameOrigin(NSMakePoint(x, y))
    stackView.autoresizingMask = NSAutoresizingMaskOptions([.viewMaxXMargin,.viewMaxYMargin,.viewMinXMargin,.viewMinYMargin])
    
    return stackView
}

