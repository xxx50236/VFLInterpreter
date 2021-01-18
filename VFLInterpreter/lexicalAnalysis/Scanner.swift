//
//  Scanner.swift
//  VFLInterpreter
//
//  Created by ChenBin on 2021/1/11.
//

import Foundation

class Scanner {
    
    let str: String
    
    private(set) var leftStr: Substring
    
    private var current: Int = 0
    private var tokens: [Token] = []
    
    required init?(input: String?) {
        guard let input = input, !input.isEmpty else {
            return nil
        }
        
        str = input
        leftStr = Substring(input)
    }
}

extension Scanner {
    
    func nextToken() -> Token? {
        guard let ch = leftStr.first else {
            return nil
        }
        
        var matchedDFA: NFA?
      
        for dfa in dfas where dfa.triggerStartState(ch: ch) {
            let res = dfa.process(str: leftStr, from: current)
            if dfa.token != nil && dfa.state == FAState.end && res.current > current {
                leftStr = res.left
                current = res.current

                matchedDFA = dfa
            }
        }
        
        if let token = matchedDFA?.token {
            tokens.append(token)
        }
        
        return matchedDFA?.token
    }
    
}

extension Scanner {
    var dfas: [NFA] {
        return []
    }
}
