//
//  ProductDetailViewController.swift
//  BaeminCopy
//
//  Created by tax_k on 08/10/2018.
//  Copyright © 2018 tax_k. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var MovieInfo: Movie?
    
    lazy var df: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M월 d일(E)"
        return f
    }()
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieImageVIewHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerBackView: UIView!
    
    @IBOutlet weak var detailListView: UITableView!
    @IBOutlet weak var floatingMenuTopConstraint: NSLayoutConstraint!
    
    var floatingMenuBase: CGFloat = 0.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButtonW: UIButton!
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var whiteMode = false
    
    var barStyle = UIStatusBarStyle.lightContent
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerBackView.alpha = 0
        movieImageView.image = UIImage(named: (MovieInfo?.imageName)!)
//        titleLabel.text = course?.title
        
        detailListView.contentInset = UIEdgeInsets(top: movieImageVIewHeightConst.constant - headerView.bounds.height, left: 0, bottom: 0, right: 0)
        detailListView.scrollIndicatorInsets = detailListView.contentInset
        
        titleLabel.alpha = 0
    }
}

extension ProductDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        print(y)
        
        let diff = y + 200
        
        floatingMenuTopConstraint.constant = floatingMenuBase - diff
        
        if y < -200 {
            movieImageVIewHeightConst.constant = 300 + abs(diff)
        } else {
            movieImageVIewHeightConst.constant = 300
        }
        
        if y >= 0 {
            if !whiteMode {
                whiteMode = true
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                    [weak self] in
                    self?.headerBackView.alpha = 1.0
                    self?.backButtonW.alpha = 1.0
//                    self?.whiteBackButton.alpha = 0.0
                    self?.titleLabel.alpha = 1.0
                    self?.titleLabel.text = self?.MovieInfo?.title
                    }, completion: nil)
                
                barStyle = .default
                setNeedsStatusBarAppearanceUpdate()
                
            }
            
        } else {
            if whiteMode {
                whiteMode = false
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                    [weak self] in
                    self?.headerBackView.alpha = 0.0
                    self?.backButtonW.alpha = 1.0
//                    self?.whiteBackButton.alpha = 1.0
                    self?.titleLabel.alpha = 0.0
                    }, completion: nil)
                
                barStyle = .lightContent
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
}
extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as! DetailTableViewCell
            
//            cell.title.text = MovieInfo?.title
            cell.titleLabel.text = MovieInfo?.title
////
////            if let start = df.string(for: MovieInfo?.startDate), let end = df.string(for: course?.endDate) {
////                cell.periodLabel.text = "\(start) ~ \(end)"
////            }
//            cell.timeLabel.text = "월요일, 수요일 19:30 ~ 22:30"
//            cell.preparationLabel.text = "xcode 9이 설치된 Mac"
//            cell.locationLabel.text = course?.location
            
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "dummy")!
        }
        
    }
}
extension ProductDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return 40
        case 2:
            return 1000
        default:
            return UITableViewAutomaticDimension
        }
    }
    
}
