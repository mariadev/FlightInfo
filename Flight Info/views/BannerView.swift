//
//  BannerView.swift
//  Flight Info
//
//  Created by Maria on 11/01/2021.
//

import UIKit

final class BannerView: UIStackView {
    static let margin: CGFloat = 16

    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageBanner = UIImage(named: "banner")!
    var statusLabel = UILabel()
    var statusBanner = UIImageView()
    
    
    private func initialize() {
        
        addImage()
        layout()
        configureStack()
        style()
    }
    
    private func configureStack() {
        alignment = .center
        axis = .vertical
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
        statusBanner.image = imageBanner
        
    }
    
    private func layout() {
        
        [statusLabel,
        statusBanner
         ].forEach {
           addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
//        summary.textAlignment = .center
          
    }
    
    private func style() {
        statusLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        statusLabel.textColor = UIColor.systemRed
        
    }
}
