//
//  ViewController.swift
//  Flight Info
//
//  Created by Maria on 09/01/2021.
//
import UIKit

class ViewController: UIViewController {
    
    let flightsView = FlightsView()
    
    private let snowView = SnowView( frame: .init(x: -150, y:-100, width: 300, height: 50) )
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layoutMarginsDidChange()
    }
}

//MARK:- UIViewController
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(flightsView)
        // Add the snow effect layer
        let snowClipView = UIView( frame: view.frame.offsetBy(dx: 0, dy: 0) )
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        // Start rotating the flights
        layout()
    }
}

private extension ViewController {
    //MARK:- Animations
    
    
    func move(label: UILabel, text: String, offset: CGPoint) {
        //TODO: Animate a label's translation property
    }
    
    func cubeTransition(label: UILabel, text: String) {
        //TODO: Create a faux rotating cube animation
    }
    
    func depart() {
        //TODO: Animate the plane taking off and landing
    }
    
    func changeSummary(to summaryText: String) {
        //TODO: Animate the summary text
    }
    
    private func layout() {
        flightsView.changeFlight(to: .londonToParis, animated: false)
        flightsView.edgeTo(view, constantBottom: -100)

    }
    
    //MARK:- utility methods
    func duplicate(_ label: UILabel) -> UILabel {
        let newLabel = UILabel(frame: label.frame)
        newLabel.font = label.font
        newLabel.textAlignment = label.textAlignment
        newLabel.textColor = label.textColor
        newLabel.backgroundColor = label.backgroundColor
        return newLabel
    }
}
