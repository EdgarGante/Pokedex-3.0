//
//  UISearchBarExtension.swift
//  Pokedex
//
//  Created by Edgar on 12/1/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import UIKit

public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
        tf.font = UIFont(name: "pokemonGB", size: 10)
    }
}
