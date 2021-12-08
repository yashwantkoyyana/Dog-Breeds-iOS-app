//
//  String.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import UIKit

extension String {
    
    
    func capitalizingFirstLetterSentenced(seperator: String = " ") -> String {
        let component = self.components(separatedBy: seperator)
        let initialedStrings = component.reduce([]) { (result, next) -> [String] in
            var mutatingResult = result
            mutatingResult.append(next.capitalizingFirstLetter())
            return mutatingResult
        }
        return initialedStrings.joined(separator: seperator)
    }
    
    mutating func capitalizingFirstLetterSentenced(seperator: String = " ") {
        self = self.capitalizingFirstLetterSentenced(seperator: seperator)
    }
    
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
