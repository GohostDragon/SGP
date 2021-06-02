//
//  StardustView.swift
//  Anagrams
//
//  Created by kpugame on 2021/04/27.
//  Copyright © 2021 Caroline. All rights reserved.
//

import UIKit

class StardustView: UIView{
    private var emitter: CAEmitterLayer!
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    required init?(coder: NSCoder) {
        fatalError("use init(frame: ")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        emitter.emitterSize = self.bounds.size
        emitter.renderMode = CAEmitterLayerRenderMode.additive
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        let emitterCell = CAEmitterCell()
        
        emitterCell.name = "cell"
        emitterCell.contents = UIImage(named: "icons8-star-48")?.cgImage
        emitterCell.birthRate = 30
        emitterCell.lifetime = 1.0
        emitterCell.velocity = 100
        emitterCell.velocityRange = 50
        emitterCell.emissionLongitude = 90
        emitterCell.emissionRange = .pi
        emitterCell.spinRange = 5
        emitterCell.scale = 0.5
        emitterCell.scaleRange = 0.5
        emitterCell.alphaSpeed = -1
        
        emitter.emitterCells = [emitterCell]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { self.removeFromSuperview()
        })
    }
}
