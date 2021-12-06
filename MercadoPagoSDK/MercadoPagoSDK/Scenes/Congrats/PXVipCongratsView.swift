//
//  PXVipCongratsView.swift
//  MercadoPagoSDK
//
//  Created by Ricardo Couto D Alambert on 23/11/21.
//  Copyright © 2021 MercadoPago. All rights reserved.
//

import UIKit
import AndesUI
import AVFoundation

protocol PXVipCongratsViewOutput: AnyObject {
    func didPushExitButton()
}

class PXVipCongratsView: UIView {
    
    weak var viewController: PXVipCongratsViewOutput?
    
    var scrollView: UIScrollView?
    var topAreaView: UIView?
    var bottomAreaView: UIView?
    var contentAreaView: UIView?
    
    var button: AndesButton?
    var label: UILabel?
    
    convenience init(backgroundColor: UIColor?, viewController: PXVipCongratsViewOutput?, presenter: PXVipCongratsPresenterInput? = nil) {
        self.init()
        
        self.viewController = viewController
        
        _ = self.backgroundColor(backgroundColor)
        
        buildInterface2()
        
        bind(presenter)
    }
    
    deinit {
        self.clearSubViews()
    }
    
    func buildInterface() {

        label = UILabel()
        
        self.addSubview(label!)
        
        NSLayoutConstraint.activate([
            label!.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            label!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            label!.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        button = AndesButton(text: "Continuar",
                             hierarchy: .loud,
                             size: .large,
                             icon: nil)
        
        self.addSubview(button!)
        
        NSLayoutConstraint.activate([
            button!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            button!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            button!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
    }
    
    func bind(_ presenter: PXVipCongratsPresenterInput? = nil) {
     
        presenter?.valor?.bind { value in
            self.button?.text = value
        }
        
        presenter?.valor?.bind { value in
            self.label?.text = value
        }
    }
    
    func buildInterface2() {
        
        self.scrollView = ScrollView {
            
            _ = $0?.VStack {
                
                self.topAreaView = self.topBar($0)
                
                self.contentAreaView = self.contentArea($0)
                
                self.bottomAreaView = self.bottomArea($0)
                
                _ = $0?.View()

            }.relatedConstraint(
                thisConstraint: .width,
                relatedTo: .width,
                relatedBy: .equal
            ).defaultConstraints()
            
        }.defaultConstraints()
        
        
        as? UIScrollView
    }
    
    private func topBar(_ parentView: UIView?) -> UIView? {
        
        let topBarView = parentView?.View {
            
            let exitButton = $0?.DefaultButton {
                _ = $0
            }.setButtonTitle("X")
             .leadingConstraint(constant: 16)
             .topConstraint(constant: 48)
             .dimensionConstraints(width: 32, height: 32)
             .setAction(.touchUpInside) {
                 self.viewController?.didPushExitButton()
             }
            
            _ = $0?.Label("Listo! Ya pagaste a Supermarket")
                .fontType(fontName: "Verdana", size: 18)
                .fontColor(.white)
                .numberOfLines(2)
                .topConstraint(relatedView: exitButton, relatedTo: .bottom, constant: 8)
                .leadingConstraint(constant: 16)
                .bottomConstraint(relatedView: $0, relatedTo: .bottom, constant: 16)
                .dimensionConstraints(width: 256)
            
            let productLogo = $0?.Image("testeImage")
                .trailingConstraint(constant: 16)
                .bottomConstraint(relatedView: $0, relatedTo: .bottom, constant: 16)
                .dimensionConstraints(width: 64, height: 64)
        }
            .dimensionConstraints(height: 192)
            .backgroundColor(UIColor.Andes.green500)
        
        return topBarView
    }
    
    private func bottomArea(_ parentView: UIView?) -> UIView? {
     
        let bottomAreaView = parentView?.View {
            
            let secondButton = $0?.AndesDefaultButton {
                _ = $0
            }.setAction(.touchUpInside) {
                print("Continuar")
            }.setButtonTitle("Ir para conta")
             .leadingConstraint(constant: 16)
             .trailingConstraint(constant: 16)
             .bottomConstraint(constant: 16)
            
            let firstButton = $0?.AndesDefaultButton {
                _ = $0
            }.setAction(.touchUpInside) {
                print("Verificar")
            }.setButtonTitle("Continuar")
             .leadingConstraint(constant: 16)
             .trailingConstraint(constant: 16)
             .bottomConstraint(relatedView:secondButton, relatedTo: .top, constant: 8)

        }
            .dimensionConstraints(height: 128)
        
        return bottomAreaView
    }
        
    private func contentArea(_ parentView: UIView?) -> UIView? {
        
        let contentArea = parentView?.View {
            
            _ = $0?.VStack {
                
                _ = $0?.View {
                   
                    let image = $0?.Image("testeImage") {
                        _ = $0
                    }.leadingConstraint(constant: 16)
                     .topConstraint(constant: 16)
                     .dimensionConstraints(width: 32, height: 42)
                    
                    _ = $0?.Label("teste")
                        .leadingConstraint(relatedView: image, relatedTo: .trailing, constant: 16)
                        .topConstraint(constant: 16)
                        .fontType(fontName: "Verdana", size: 18.0)
                        .fontColor(.white)
                    
                }.backgroundColor(.lightGray)
                 .dimensionConstraints(height: 192)
                
                _ = $0?.View {
                    _ = $0
                }.backgroundColor(.lightBlue())
                 .dimensionConstraints(height: 64)
                
                _ = $0?.View {
                    _ = $0
                }.backgroundColor(.white)
            }
             .topConstraint(constant: 0)
             .leadingConstraint(constant: 0)
             .trailingConstraint(constant: 0)
             .bottomConstraint(constant: 0)
             .backgroundColor(.blue)
                
        }.backgroundColor(.white)
         .dimensionConstraints(height: 1024)
        
        return contentArea
    }
}
