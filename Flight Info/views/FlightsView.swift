//
//  FlightsView.swift
//  Flight Info
//
//  Created by Maria on 09/01/2021.
//
import UIKit

public final class FlightsView: UIView {

    public init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let background =  UIImageView(frame: UIScreen.main.bounds)
    
    let flightSummaryView = UIView()
    let flightSummaryViewInterior = UIView()
    let summaryIcon =  UIImageView()
    let summary = UILabel()
    
    let flightDetailView = UIView()
    let flightInfoTopView = UIView()
    let flightNumberLabel = UILabel()
    let gateNumberLabel = UILabel()
    let flightInfoBottomView = UIView()
    let flightTextLabel = UILabel()
    let gateTextLabel = UILabel()
    
    let planeView = UIView()
    let originLabel = UILabel()
    let plane = UIImageView()
    let destinationLabel = UILabel()
    
    let bannerView = UIView()
    let statusLabel = UILabel()
    let statusBanner = UIImageView()
    
    private func initialize() {
        addImages()
        addViewFixHeight()
        style()
        layout()
        addTex()
    }
    
    private func addTex() {
        flightTextLabel.text = "Flight"
        gateTextLabel.text = "Gate"
        
    }
    
    private func addImages() {
        background.image = backgroundSnowy
        background.contentMode =  UIView.ContentMode.scaleAspectFill
        self.insertSubview(background, at: 0)
        
        plane.image =  imagePlane
        summaryIcon.image = imageSummary
        statusBanner.image = imageBanner
        
    }
    
    private func addViewFixHeight() {
        flightSummaryView.setHeight(sectionHeight)
        flightInfoTopView.setHeight(sectionHeight)
        flightInfoBottomView.setHeight(sectionHeight)
        bannerView.setHeight(sectionHeight)
    }
 
    
    private func layout() {
  
        self.VStack(flightSummaryView, flightDetailView, bannerView)

        flightSummaryView.positionRelativeToView(self)
        flightSummaryView.addSubview(flightSummaryViewInterior)
        flightSummaryViewInterior.positionRelativeToView(flightSummaryView, position: .center)
        flightSummaryViewInterior.HStack(summaryIcon,
                                         summary,
                                         spacing: 16
                                         )
                              
        flightDetailView.stickToTop(topView: flightSummaryView, leadingView: self, trailingView: self)
        flightDetailView.VStack( flightInfoTopView.HStack(flightTextLabel,
                                                          gateTextLabel,
                                                          distribution: .fillEqually),
                                 
                                 flightInfoBottomView.HStack(flightNumberLabel,
                                                             gateNumberLabel,
                                                             distribution: .fillEqually)
                                 .padding([.verticalMargins], amount: padding),
                                 
                                 planeView.HStack(originLabel,
                                                  plane,
                                                  destinationLabel,
                                                  alignment: .bottom,
                                                  distribution: .fillProportionally)
                                 .padding([.bottom], amount: padding),
                                 
                distribution: .fill)
                .padding([.allMargins], amount: padding)
        
        bannerView.addSubview(statusLabel)
        bannerView.addSubview(statusBanner)
        bannerView.positionRelativeToView(self, position: .stickToBottom)
//        statusLabel.positionRelativeToView(bannerView, position: .stickToBottom)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.centerYWithConstant(view: bannerView, constant: -5)
        statusBanner.positionRelativeToView(bannerView, position: .toBottomAndCenter)
        bannerView.bringSubviewToFront(statusLabel)


    }
    
    private func style() {
        backgroundColor = .white
        flightSummaryView.backgroundColor = Colors.black
        
        summary.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        summary.textColor = UIColor.white
        
        [flightNumberLabel,
         gateNumberLabel
        ].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
            $0.textColor = UIColor.white
        }
        
        plane.contentMode = .scaleAspectFit
        plane.clipsToBounds = true
        bannerView.contentMode = .scaleAspectFit
        bannerView.clipsToBounds = true
        summaryIcon.contentMode = .scaleAspectFit
        summaryIcon.clipsToBounds = true
        
        [gateTextLabel,
         gateNumberLabel,
         destinationLabel
        ].forEach {
            $0.textAlignment = .right
        }
        
        [flightTextLabel,
         gateTextLabel,
         originLabel,
          destinationLabel
        ].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2).bold()
        }
        
        [originLabel,
          destinationLabel
        ].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1).bold()
        }
        
        [flightTextLabel,
         gateTextLabel,
        ].forEach {
            $0.textColor = UIColor.white
        }
        
        [ originLabel,
          destinationLabel
        ].forEach {
            $0.textColor = Colors.cream
        }
        statusLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        statusLabel.textColor = UIColor.systemRed
        statusLabel.textAlignment = .center
        
    }
    
}
