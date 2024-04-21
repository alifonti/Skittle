//
//  MolkkyKeyboardController.swift
//  UpNorthMolkky
//
//  Created by Anthony LiFonti on 9/26/23.
//

import SwiftUI

struct SwiftUIButton: View{
    func addScore(value: Int) {
        print("addScore")
    }
    
    var body: some View{
        VStack() {
            ScoreHistoryView(round: .constant(MolkkyRound.sampleData))
                .padding([.top], 10 )
                .padding([.bottom], -10 )
            ScoreKeyboardView(round: .constant(MolkkyRound.sampleData), onSubmitScore: addScore)
                .padding()
        }
        .background(Color(UIColor.secondarySystemBackground))
    }
}

class KeyboardViewController: UIInputViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let child = UIHostingController(rootView: SwiftUIButton())
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(child.view)
    }
}
