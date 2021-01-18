//
//  planeView.swift
//  Flight Info
//
//  Created by Maria on 11/01/2021.
//

import UIKit

final class PlaneView: UIStackView {
    static let margin: CGFloat = 16

    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imagePlane = UIImage(named: "plane")!

    var originLabel = UILabel()
    var destinationLabel = UILabel()
    var plane = UIImageView()

    
    
    private func initialize() {
        
        addImage()
        layout()
        configureStack()
        style()
    }
    
    private func configureStack() {
        alignment = .center
        axis = .horizontal
        distribution = .equalSpacing
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
        plane.image =  imagePlane
        
    }
    
    private func layout() {
        
        [originLabel,
         plane,
         destinationLabel].forEach {
           addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
//        summary.textAlignment = .center
          
    }
    
    private func style() {
        originLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        destinationLabel.textColor = UIColor.white
        
    }
}
