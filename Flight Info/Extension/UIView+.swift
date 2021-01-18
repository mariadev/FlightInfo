//
//  UIView+.swift
//  Flight Info
//
//  Created by Maria on 11/01/2021.
//


import UIKit

public enum ViewSafeArea {
    case top, leading, trailing, bottom, vertical, horizontal, all, none
}
public enum PositionRelativeToView {
    case stickToTop, stickToBottom, center, toBottomAndCenter
}

extension UIView {
    
    @discardableResult
    public func edgeTo(_ view: UIView, safeArea: ViewSafeArea = .none, constantTop: CGFloat = 0, constantLeanding: CGFloat = 0, constantTrainling: CGFloat = 0, constantBottom: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        
        switch safeArea {
        case .top:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constantTop).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantLeanding).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantTrainling).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constantBottom).isActive = true
        case .leading:
            topAnchor.constraint(equalTo: view.topAnchor, constant: constantTop).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constantLeanding).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantTrainling).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constantBottom).isActive = true
        case .trailing:
            topAnchor.constraint(equalTo: view.topAnchor, constant: constantTop).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantLeanding).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: constantTrainling).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constantBottom).isActive = true
        case .bottom:
            topAnchor.constraint(equalTo: view.topAnchor, constant: constantTop).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantLeanding).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantTrainling).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constantBottom).isActive = true
        case .vertical:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constantTop).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantLeanding).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantTrainling).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constantBottom).isActive = true
        case .horizontal:
            topAnchor.constraint(equalTo: view.topAnchor, constant: constantTop).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constantLeanding).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: constantTrainling).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constantBottom).isActive = true
        case .all:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constantTop).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constantLeanding).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: constantTrainling).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constantBottom).isActive = true
        case .none:
            topAnchor.constraint(equalTo: view.topAnchor, constant: constantTop).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantLeanding).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constantTrainling).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constantBottom).isActive = true
        }
        return self
    }
}

extension UIView {
    @discardableResult
    open func setFrame(_ size: CGSize) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    open func setHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func setWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
}

extension UIView {
    @discardableResult
    public func positionRelativeToView(_ view: UIView, position: PositionRelativeToView = .stickToTop) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        switch position {
        case .stickToTop:
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        case .stickToBottom:
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
 
        case .center:
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
        case .toBottomAndCenter:
           bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            centerXAnchor.constraint(equalTo:  view.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo:  view.centerYAnchor).isActive = true
        }
        return self
    }
    
    @discardableResult
    public func stickToTop( topView: UIView, leadingView: UIView, trailingView: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
            leadingAnchor.constraint(equalTo:  leadingView.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: trailingView.trailingAnchor).isActive = true
        
        return self
    }
    
    @discardableResult
    public func stickToBottom(bottomView: UIView, leadingView: UIView, trailingView: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo:   leadingView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: trailingView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo:  bottomView.bottomAnchor).isActive = true
        
        return self
    }
    
    @discardableResult
    public func center(view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return self
    }
    
    @discardableResult
    public func toBottomAndCenter(bottomView: UIView,view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        centerXAnchor.constraint(equalTo:  view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo:  view.centerYAnchor).isActive = true
    
        
        return self
    }
    
}
