//
//  ViewController.swift
//  Example
//
//  Created by Bryce Dougherty on 5/3/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import swiftVibrant

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vibrantView = UIView(frame: CGRect(x: 0, y: 100, width: 50, height: 50))
        let darkVibrant = UIView(frame: CGRect(x: 50, y: 100, width: 50, height: 50))
        let lightVibrant = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        let muted = UIView(frame: CGRect(x: 150, y: 100, width: 50, height: 50))
        let lightmuted = UIView(frame: CGRect(x: 200, y: 100, width: 50, height: 50))
        let darkMuted = UIView(frame: CGRect(x: 250, y: 100, width: 50, height: 50))
        self.view.addSubview(vibrantView)
        self.view.addSubview(darkVibrant)
        self.view.addSubview(lightVibrant)
        self.view.addSubview(muted)
        self.view.addSubview(lightmuted)
        self.view.addSubview(darkMuted)
        super.viewDidLoad()
        
        
        vibrantView.backgroundColor =      UIColor.white
        darkVibrant.backgroundColor =      UIColor.white
        lightVibrant.backgroundColor =     UIColor.white
        muted.backgroundColor =            UIColor.white
        lightmuted.backgroundColor =       UIColor.white
        darkMuted.backgroundColor =        UIColor.white
        
        let img = UIImage(named: "bush")!
        
        Vibrant.from(img).maxDimension(100).getPalette { palette in
            vibrantView.backgroundColor =      palette.Vibrant?.uiColor
            darkVibrant.backgroundColor =      palette.DarkVibrant?.uiColor
            lightVibrant.backgroundColor =     palette.LightVibrant?.uiColor
            muted.backgroundColor =            palette.Muted?.uiColor
            lightmuted.backgroundColor =       palette.LightMuted?.uiColor
            darkMuted.backgroundColor =        palette.DarkMuted?.uiColor
        }
        
        
    }
    
}
