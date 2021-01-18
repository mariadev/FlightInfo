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
    
    let generalView = UIView()
    
    let flightSummaryView = UIView()
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
        flightSummaryView.setHeight(sectionSummaryHeight)
        flightInfoTopView.setHeight(sectionHeight)
        flightInfoBottomView.setHeight(sectionHeight)
        bannerView.setHeight(sectionHeight)
    }
 
    
    private func layout() {
        self.addSubview(generalView)
        
        generalView.VStack(flightSummaryView, flightDetailView, bannerView)
        generalView.edgeTo(self)
        
        flightSummaryView.positionRelativeToView(self)
        flightSummaryView.HStack(summaryIcon,
                                 summary,
                                 center: true)
            .padding([.horizontalMargins], amount: padding*2)
//            .height(sectionSummaryHeight)
        
        
        flightDetailView.stickToTop(topView: flightSummaryView, leadingView: self, trailingView: self)
        
        flightDetailView.VStack( flightInfoTopView.HStack(flightTextLabel,
                                                          gateTextLabel,
                                                          distribution: .fillEqually),
//                                    .height(sectionHeight),
                                 
                                 flightInfoBottomView.HStack(flightNumberLabel,
                                                             gateNumberLabel,
                                                             distribution: .fillEqually)
                                 .padding([.verticalMargins], amount: padding),
//                                    .height(sectionHeight),
                                 
                                 planeView.HStack(originLabel,
                                                  plane,
                                                  destinationLabel,
                                                  alignment: .bottom,
                                                  distribution: .fillProportionally),
                                 
         distribution: .fill)
        .padding([.allMargins], amount: padding)

//        bannerView.setHeight(sectionHeight)
        bannerView.addSubview(statusLabel)
        bannerView.addSubview(statusBanner)
        bannerView.positionRelativeToView(self, position: .stickToBottom)
        statusLabel.positionRelativeToView(bannerView, position: .toBottomAndCenter)
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
         gateTextLabel
        ].forEach {
            $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
            $0.textColor = UIColor.white
        }
        
        originLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        destinationLabel.textColor = UIColor.white
        statusLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        statusLabel.textColor = UIColor.systemRed
        
    }
    private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }
    
}

extension FlightsView {
    
    func fade(to image: UIImage, showEffects: Bool) {
        //         Create & set up temp view
        let tempView = UIImageView(frame: background.frame)
        tempView.image = image
        tempView.alpha = 0
        tempView.center.y += 20
        tempView.bounds.size.width = background.bounds.width * 1.3
        background.superview!.insertSubview(tempView, aboveSubview: background)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                // Fade temp view in
                tempView.alpha = 1
                tempView.center.y -= 20
                tempView.bounds.size = self.background.bounds.size
            },
            completion: { _ in
                // Update background view & remove temp view
                self.background.image = image
                tempView.removeFromSuperview()
            }
        )
    }
    
    func changeFlight(to flight: Flight, animated: Bool = false) {
        // populate the UI with the next flight's data
        originLabel.text = flight.origin
        destinationLabel.text = flight.destination
        flightNumberLabel.text = flight.number
        gateNumberLabel.text = flight.gateNumber
        statusLabel.text = flight.status
        summary.text = flight.summary
        
        if animated {
            fade(
                to: UIImage(named: flight.weatherImageName)!,
                showEffects: flight.showWeatherEffects
            )
        } else {
            background.image = UIImage(named: flight.weatherImageName)
        }
        //         schedule next flight
        delay(seconds: 3) {
            self.changeFlight(
                to: flight.isTakingOff ? .parisToRome : .londonToParis,
                animated: true
            )
        }
        
    }
}
