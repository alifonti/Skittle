//
//  MolkkyKeyboardView.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/26/23.
//

import SwiftUI

struct MolkkyKeyboardView: UIViewControllerRepresentable {
    typealias UIViewControllerType = KeyboardViewController
    
    func makeUIViewController(context: Context) -> KeyboardViewController {
        let vc = KeyboardViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: KeyboardViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
