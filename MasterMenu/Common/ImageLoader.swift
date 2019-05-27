//
//  ImageLoader.swift
//  MasterMenu
//
//  Created by NEOApp Tecnologia Ltda on 25/05/19.
//  Copyright © 2019 NEOApp Tecnologia Ltda. All rights reserved.
//

import UIKit
import Kingfisher

protocol ImageLoaderDelegate {
    func loadedImage()
}

class ImageLoader: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var delegate:ImageLoaderDelegate?
    var placeholder:String = "placeholder-image.png"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    func setUp(){
        UINib(nibName: "ImageLoader", bundle: nil).instantiate(withOwner: self, options: nil)
        self.bounds = self.view.bounds
        self.view.bounds = self.bounds;
        self.addSubview(self.view)
    }
    
    func loadImage(url:String, save:Bool = false){
        loader.startAnimating()
        let nsurl = URL(string: url)
        self.imgView.alpha = 0
        imgView.kf.setImage(with: nsurl, placeholder: nil, options:nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            if(error != nil){
                self.imgView.image = UIImage.init(named: self.placeholder)
            }else{
                if(save == true){
                    let defaults:UserDefaults
                    defaults = UserDefaults.standard
                    defaults.setValue(self.imgView.image!.pngData() as NSData?, forKey: url)
                    defaults.synchronize()
                }
            }
            self.delegate?.loadedImage()
            UIView.animate(withDuration: 0.5, animations: {
                self.imgView.alpha = 1
            })
            self.loader.stopAnimating()
        })
    }
    
    func loadLocal(image:String){
        self.imgView.image = UIImage.init(named: image)
        self.imgView.alpha = 1
    }
    
}
