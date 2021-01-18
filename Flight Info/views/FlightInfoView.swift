//
//  FlightInfoView.swift
//  Flight Info
//
//  Created by Maria on 11/01/2021.
//

import UIKit

final class FlightInfoView: UIStackView {
    
    static let margin: CGFloat = 16

    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    var flightNumberLabel = UILabel()
    var gateNumberLabel = UILabel()
    var flightTextLabel = UILabel()
    var gateTextLabel = UILabel()
    var horizontaleStack1 = UIStackView()
    var horizontaleStack2 = UIStackView()
    
    private func initialize() {

        layout()
        configureStacks()
        style()
        flightTextLabel.text = "Flight"
        gateTextLabel.text = "Gate"
    }
    
    private func configureStacks() {
        
        axis = .vertical
        distribution = .fill
        isLayoutMarginsRelativeArrangement = true
        spacing = Self.margin
//        alignment = .center
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: Self.margin,
            bottom: Self.margin,
            trailing: Self.margin
        )
        
        [horizontaleStack1,
         horizontaleStack2,
        ].forEach {
            $0.axis = .horizontal
            $0.distribution = .fillProportionally
            
        }
        
    }
    
    
    private func layout() {
        
        [horizontaleStack1,
         horizontaleStack2
        ].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
//        summary.textAlignment = .center
        [flightTextLabel,
         gateTextLabel
        ].forEach {
            horizontaleStack1.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [flightNumberLabel,
         gateNumberLabel,
        ].forEach {
            horizontaleStack2.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func style() {
        
        [flightNumberLabel,
         gateNumberLabel
        ].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
            $0.textColor = UIColor.white
        }
        
        
        [gateTextLabel,
         gateNumberLabel
        ].forEach {
            $0.textAlignment = .right
        }
        
        [flightTextLabel,
         gateTextLabel
        ].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
            $0.textColor = UIColor.white
        }
    }
}
