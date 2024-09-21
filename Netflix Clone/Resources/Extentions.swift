//
//  Extentions.swift
//  Netflix Clone
//
//  Created by Virgi Septian on 22/09/24.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
