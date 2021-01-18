//
//  FlightDetailView.swift
//  Flight Info
//
//  Created by Maria on 09/01/2021.
//

import UIKit

final class FlightSummaryView: UIStackView {
    static let margin: CGFloat = 16

    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageSummary = UIImage(named: "icon-blue-arrow")!
    var summaryIcon =  UIImageView()
    var summary = UILabel()
    
    
    private func initialize() {
        
        addImage()
        layout()
        configureStack()
        style()
    }
    
    private func configureStack() {
        alignment = .center
        axis = .horizontal
        distribution = .fillProportionally
        isLayoutMarginsRelativeArrangement = true
        spacing = Self.margin
//        alignment = .center
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: Self.margin,
            bottom: Self.margin,
            trailing: Self.margin
        )
        
    }
    
    private func addImage() {
        summaryIcon.image = imageSummary
        
    }
    
    private func layout() {
        
        [ summaryIcon,
          summary,
        ].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
//        summary.textAlignment = .center
          
    }
    
    private func style() {
        backgroundColor = .black
        summary.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        summary.textColor = UIColor.white
        
    }
}
