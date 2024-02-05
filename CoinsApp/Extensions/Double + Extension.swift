//
//  Double + Extension.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 26.01.24.
//

import Foundation

extension Double {
    func rounding () -> String {
        return String(format: "%.2f", abs(self))
    }
}
