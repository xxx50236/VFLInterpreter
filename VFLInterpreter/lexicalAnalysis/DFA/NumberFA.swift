//
//  NumberFA.swift
//  VFLInterpreter
//
//  Created by CB on 2021/1/18.
//

import Foundation

struct NumberFA: FiniteAutomaton {
    
    var tokenType: TokenType {
        return .number
    }
    
    func stateTransform(from state: FAState, accept ch: Character?) -> FAState {
        
        guard let ch = ch else {
            return state
        }
        
        if state == .start {
            return ch.isNumber ? acceptState : .invalid
        } else if state == acceptState {
            return ch.isNumber ? acceptState : .end
        } else {
            return .invalid
        }
    }
    
    func matched(accept ch: Character) -> Bool {
        return ch.isNumber
    }
}

extension NumberFA {
    var acceptState: FAState {
        return FAState(rawValue: "number")
    }
}
