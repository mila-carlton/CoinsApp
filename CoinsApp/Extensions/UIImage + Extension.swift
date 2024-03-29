//
//  UIImage + Extension.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 26.01.24.
//

import UIKit


extension UIImageView {
    func loadImage(imageURL: String) {
        if let url = URL(string: imageURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data )
                    }
                } else {
                    DispatchQueue.main.async {
                        self.image = nil
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.image = nil
            }
        }
    }
}
