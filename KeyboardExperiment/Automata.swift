//
//  Automata.swift
//  KeyboardExperiment
//
//  Created by Park Seongheon on 6/3/24.
//

import UIKit

final class Automata: ObservableObject {
    private let chosungTable = ["ㄱ": 0, "ㄲ": 1, "ㄴ": 2, "ㄷ": 3, "ㄸ": 4, "ㄹ": 5, "ㅁ": 6, "ㅂ": 7, "ㅃ": 8, "ㅅ": 9, "ㅆ": 10, "ㅇ": 11, "ㅈ": 12, "ㅉ": 13, "ㅊ": 14, "ㅋ": 15, "ㅌ": 16, "ㅍ": 17, "ㅎ": 18]
    private let jungsungTable = ["ㅏ": 0, "ㅐ": 1, "ㅑ": 2, "ㅒ": 3, "ㅓ": 4, "ㅔ": 5, "ㅕ": 6, "ㅖ": 7, "ㅗ": 8, "ㅘ": 9, "ㅙ": 10, "ㅚ": 11, "ㅛ": 12, "ㅜ": 13, "ㅝ": 14, "ㅞ": 15, "ㅟ": 16, "ㅠ": 17, "ㅡ": 18, "\u{3162}": 19, "ㅣ": 20]
    private let jongsungTable = ["": 0, "ㄱ": 1, "ㄲ": 2, "ㄳ": 3, "ㄴ": 4, "ㄵ": 5, "ㄶ": 6, "ㄷ": 7, "ㄹ": 8, "ㄺ": 9, "ㄻ": 10, "ㄼ": 11, "ㄽ": 12, "ㄾ": 13, "ㄿ": 14, "ㅀ": 15, "ㅁ": 16, "ㅂ": 17, "ㅄ": 18, "ㅅ": 19, "ㅆ": 20, "ㅇ": 21, "ㅈ": 22, "ㅊ": 23, "ㅋ": 24, "ㅌ": 25, "ㅍ": 26, "ㅎ": 27]
    
    private var baseCode: Int? = nil
    private var sparse: [String] = []
    
//    @Published
//    private(set) var composingPreview = ""
    
    var isJongFull: Bool {
        get {
            switch sparse {
                case ["ㄱ"], ["ㄱ", "ㅅ"], ["ㄴ"], ["ㄴ", "ㅈ"], ["ㄴ", "ㅎ"], ["ㄷ"], ["ㄸ"], ["ㄹ"], ["ㄹ", "ㄱ"], ["ㄹ", "ㅁ"], ["ㄹ", "ㅂ"], ["ㄹ", "ㅅ"], ["ㄹ", "ㅌ"], ["ㄹ", "ㅍ"], ["ㄹ", "ㅎ"], ["ㅁ"], ["ㅂ"], ["ㅂ", "ㅅ"], ["ㅃ"], ["ㅅ"], ["ㅆ"], ["ㅇ"], ["ㅈ"], ["ㅉ"], ["ㅊ"], ["ㅋ"], ["ㅌ"], ["ㅍ"], ["ㅎ"]:
                return true
            default:
                return false
            }
        }
    }
    
    weak var proxy: UITextDocumentProxy!
    
    init(proxy: UITextDocumentProxy) {
        self.proxy = proxy
    }
    
    /// 글자를 조건에 맞게 입력한다.
    /// 자음만 받은 경우 이어 결합하는 것을 원칙으로 한다. 자음과 모음을 함께 받는 경우 결합을 종료하고 무조건 다음 글자를 생성한다.
    func input(consonent: String, syllable: Int? = nil) {
        if let syllable {
            sparse = []
            baseCode = generateUnicode(cho: consonent, jung: syllable)
            proxy.insertText("\(UnicodeScalar(baseCode!)!)")
        } else if baseCode != nil {
            sparse.append(consonent)
            let code = generateUnicodeWithBaseCode()
            proxy.deleteBackward()
            print("\(UnicodeScalar(code)!)")
            proxy.insertText("\(UnicodeScalar(code)!)")
            
            if isJongFull {
                endComposing()
            }
        } else {
            proxy.insertText("\(UnicodeScalar(0x1100 + chosungTable[consonent]!)!)")
            endComposing()
        }
    }
    
    func generateUnicode(cho: String, jung: Int) -> Int {
        return 0xAC00 + (chosungTable[cho]! * 588) + (jung * 28)
    }
    
    func generateUnicodeWithBaseCode() -> Int {
        let jong = switch sparse {
        case ["ㄱ", "ㅅ"]:
            3
        case ["ㄴ", "ㅈ"]:
            5
        case ["ㄴ", "ㅎ"]:
            6
        case ["ㄹ", "ㄱ"]:
            9
        case ["ㄹ", "ㅁ"]:
            10
        case ["ㄹ", "ㅂ"]:
            11
        case ["ㄹ", "ㅅ"]:
            12
        case ["ㄹ", "ㅌ"]:
            13
        case ["ㄹ", "ㅍ"]:
            14
        case ["ㄹ", "ㅎ"]:
            15
        case ["ㅂ", "ㅅ"]:
            18
        default:
            jongsungTable[sparse.first!]!
        }
        
        return (self.baseCode ?? 0xAC00) + jong
    }
    
    func endComposing() {
        sparse = []
        baseCode = nil
    }
}
