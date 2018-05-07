//: Playground - noun: a place where people can play

import Cocoa

private enum Theme {
    enum Color {
        static let border = NSColor(red: CGFloat(184/255.0), green: 201/255.0, blue: 238/255.0, alpha: 1)
        static let shade = NSColor(red: CGFloat(227/255.0), green: 234/255.0, blue: 249/255.0, alpha: 1)
        static let highlight = NSColor(red: CGFloat(14/255.0), green: 114/255.0, blue: 199/255.0, alpha: 1)
    }
    enum Font {
        static let codeVoice = NSFont(name: "Menlo-Regular", size: 14)!
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
        isBordered = true
        //        if (styledString.bordered) {
//                    borderColor = Theme.Color.border.cgColor
//                    borderWidth = 1.0
        //        }
    }
}

public func visualize(_ str: String) -> NSView {
    return _visualize(str, range: nil)
}

public func visualize(_ str: String, index: String.Index) -> NSView {
    let range = index..<str.index(after:index)
    return _visualize(str, range: range)
}

public func visualize(_ str: String, range: Range<String.Index>) -> NSView {
    return _visualize(str, range: range)
}

private func _visualize(_ str: String, range: Range<String.Index>?) -> NSView {
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
    
        let styledIndices = stringIndices.enumerated().map { (index, characterIndex) -> StyledString in
//            let highlighted: Bool
//            let nextCharacterIndex = str.characters.index(after: characterIndex)
//            if range?.lowerBound == characterIndex || range?.upperBound == nextCharacterIndex {
//                highlighted = true
//            } else {
//                highlighted = false
//            }
    
            return StyledString(string: String(index), isWaitingTyping: false)
        }
    
        let indexLabels = styledIndices.map { NSTextField(styledString: $0) }
    
        let charStacks: [NSStackView] = zip(characterLabels, indexLabels).map { (charLabel, indexLabel) in
            let stack = NSStackView()
            //stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.addArrangedSubview(indexLabel)
            stack.addArrangedSubview(charLabel)
            return stack
        }
    
    let stackView = NSStackView(frame: CGRect(x: 0, y: 0, width: 25 * charStacks.count, height: 50))
    stackView.distribution = .fillEqually
    charStacks.forEach(stackView.addArrangedSubview)
    
    return stackView
}

var str = "Héllo, 🇺🇸laygr😮und!"

visualize(str)
