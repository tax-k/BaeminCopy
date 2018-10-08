//
//  ViewController.swift
//  BaeminCopy
//
//  Created by tax_k on 08/10/2018.
//  Copyright © 2018 tax_k. All rights reserved.
//

import UIKit

struct Movie {
    let title: String
    let imageName: String
    let startDate: Date
    let tags: [String]
    let location: String
}

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var indicateBar: UIView!
    @IBOutlet weak var IndicatorWidthConst: NSLayoutConstraint!
    
    @IBOutlet weak var Indicator1CenterConst: NSLayoutConstraint!
    @IBOutlet weak var Indicator2CenterConst: NSLayoutConstraint!
    @IBOutlet weak var Indicator3CenterConst: NSLayoutConstraint!
    @IBOutlet weak var Indicator4CenterConst: NSLayoutConstraint!
    
    
    @IBAction func selectAction(_ sender: UIButton) {
        
        Indicator1CenterConst.isActive = sender.tag == 100
        Indicator2CenterConst.isActive = sender.tag == 200
        Indicator3CenterConst.isActive = sender.tag == 300
        Indicator4CenterConst.isActive = sender.tag == 400
        
//        sender.setTitleColor(UIColor.white, for: .normal)
        
        // indicator 이동할때 글자 크기에 따라 width 변경
        if let title = sender.title(for: .normal), let font = sender.titleLabel?.font {
            let attr = [NSAttributedStringKey.font: font]
            let width = (title as NSString).size(withAttributes: attr).width
            let activateColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
            
            sender.setTitleColor(activateColor, for: .normal)
            IndicatorWidthConst.constant = width
            
        }
        UIView.animate(withDuration: 0.3) {
            [weak self] in self?.view.layoutIfNeeded()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selectAction(startButton)
    }

}

