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
        changeFlight(to: .londonToParis, animated: false)
        layout()
    }
}

private extension ViewController {
    private func layout() {
        
        view.addSubview(flightsView)
        flightsView.edgeTo(view)

        let snowClipView = UIView( frame: view.frame.offsetBy(dx: 0, dy: 0) )
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)

    }
}

private extension ViewController {
    //MARK:- Animations
    
    private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }
    
    func fade(to image: UIImage, showEffects: Bool) {
        //         Create & set up temp view
        let tempView = UIImageView(frame: flightsView.background.frame)
        tempView.image = image
        tempView.alpha = 0
        tempView.center.y += 20
        tempView.bounds.size.width = flightsView.background.bounds.width * 1.3
        flightsView.background.superview!.insertSubview(tempView, aboveSubview:  flightsView.background)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                // Fade temp view in
                tempView.alpha = 1
                tempView.center.y -= 20
                tempView.bounds.size = self.flightsView.background.bounds.size
            },
            completion: { _ in
                // Update background view & remove temp view
                self.flightsView.background.image = image
                tempView.removeFromSuperview()
            }
        )
        
        UIView.animate(
          withDuration: 1, delay: 0,
          options: .curveEaseOut,
          animations: { self.snowView.alpha = showEffects ? 1 : 0 }
        )
    }
    
    func move(label: UILabel, text: String, offset: CGPoint) {
        
        let tempLabel = duplicate(label)
        tempLabel.text = text
        tempLabel.transform = .init(translationX: offset.x, y: offset.y)
        tempLabel.alpha = 0
        view.addSubview(tempLabel)

        // Fade out and translate real label
        UIView.animate(
          withDuration: 0.5, delay: 0,
          options: .curveEaseIn,
          animations: {
            label.transform = .init(translationX: offset.x, y: offset.y)
            label.alpha = 0
          }
        )

        // Fade in and translate temp label
        UIView.animate(
          withDuration: 0.25, delay: 0.2,
          options: .curveEaseIn,
          animations: {
            tempLabel.transform = .identity
            tempLabel.alpha = 0
          },
          completion: { _ in
            // Update real label and remove temp label
            label.text = text
            label.alpha = 1
            label.transform = .identity
            tempLabel.removeFromSuperview()
          }
        )
    }
    
    func cubeTransition(label: UILabel, text: String) {
        // Create and set up temp label
    let tempLabel = duplicate(label)
    tempLabel.text = text
    let tempLabelOffset = label.frame.size.height / 2
        let scale = CGAffineTransform(scaleX: 0, y: 0.1)
    let translate = CGAffineTransform(translationX: 0, y: tempLabelOffset)
    tempLabel.transform = scale.concatenating(scale)
    label.superview!.addSubview(tempLabel)

    UIView.animate(
      withDuration: 0.5, delay: 0,
      options: .curveEaseOut,
      animations: {
        // Scale temp label down and translate up
        tempLabel.transform = .identity

        // Scale real label down and translate up
        label.transform = scale.concatenating( translate.inverted() )
      },
      completion: { _ in
        // Update the real label's text and reset its transform
        label.text = tempLabel.text
        label.transform = .identity

        tempLabel.removeFromSuperview()
      }
    )
    }
    
    func depart() {
        let originalCenter =  flightsView.plane.center
        UIView.animateKeyframes(
          withDuration: 1.5, delay: 0,
            animations: { [plane = self.flightsView.plane] in
            // Move plane right & up
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
              plane.center.x += 80
              plane.center.y -= 10
            }

            // Rotate plane
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
              plane.transform = .init(rotationAngle: -.pi / 8)
            }

            // Move plane right and up off screen, while fading out
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
              plane.center.x += 100
              plane.center.y -= 50
              plane.alpha = 0
            }

            // Move plane just off left side, reset transform and height
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
              plane.transform = .identity
              plane.center = .init(x: 0, y: originalCenter.y)
            }

            // Move plane back to original position & fade in
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
              plane.alpha = 1
              plane.center = originalCenter
            }
          }
        )    }
    
    func changeSummary(to summaryText: String) {
        self.view.layoutIfNeeded()
        UIView.animateKeyframes(
          withDuration: 1, delay: 0,
            animations: { [summary = self.flightsView.flightSummaryViewInterior] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45) {
                summary.center.y -= 100
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.45) {
              summary.center.y += 100
            }
          }
        )

        delay(seconds: 0.5) { self.flightsView.summary.text = summaryText }
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

extension ViewController {
    
    func changeFlight(to flight: Flight, animated: Bool = false) {
        // populate the UI with the next flight's data
        flightsView.flightNumberLabel.text = flight.number
        flightsView.gateNumberLabel.text = flight.gateNumber
        
        if animated {
            fade(
                to: UIImage(named: flight.weatherImageName)!,
                showEffects: flight.showWeatherEffects
            )
            
            move(label:  flightsView.originLabel,
                 text: flight.origin,
                 offset: CGPoint(x: 0, y: -50))
            move(label:  flightsView.destinationLabel,
                 text: flight.destination,
                 offset:  CGPoint(x: 0, y: -50)
            )
            
            cubeTransition(label: flightsView.statusLabel, text: flight.status)
            depart()
            changeSummary(to: flight.summary)
        } else {
            flightsView.background.image = UIImage(named: flight.weatherImageName)
            flightsView.originLabel.text = flight.origin
            flightsView.destinationLabel.text = flight.destination
            flightsView.statusLabel.text = flight.status
            flightsView.summary.text = flight.summary
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
