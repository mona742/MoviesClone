//
//  Extensions.swift
//  MoviesClone
//
//  Created by mona alshiakh on 25/07/1444 AH.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
