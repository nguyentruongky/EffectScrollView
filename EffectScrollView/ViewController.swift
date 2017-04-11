//
//  ViewController.swift
//  EffectScrollView
//
//  Created by Ky Nguyen on 10/13/15.
//  Copyright © 2015 Ky Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: AnimationScrollView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var leftNextButtonConstraint: NSLayoutConstraint!
    
    @IBAction func loadPrevious(_ sender: AnyObject) {
        
        scrollView.loadPreviousPage(true)
    }
    
    @IBAction func loadNext(_ sender: AnyObject) {
        
        scrollView.loadNextPage(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func changeEffect(_ sender: AnyObject) {

        var animation = AnimationType.none
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            animation = AnimationType.cards

        case 1:
            animation = AnimationType.carousel
        
        case 2:
            animation = AnimationType.depth
        
        case 3:
            animation = AnimationType.translation
            
        default:
            break
        }
        
        scrollView.effect = animation
        scrollView.setEffect(animation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.scrollView.effect = AnimationType.carousel
        
        scrollView.delegate = self
        
        createCardWithColor()
        createCardWithColor()
        createCardWithColor()
        createCardWithColor()
        createCardWithColor()

        nextButton.backgroundColor = UIColor(red: 33/255.0, green: 158/255.0, blue: 238/255.0, alpha: 1.0)
        nextButton.layer.cornerRadius = 5.0
        previousButton.layer.cornerRadius = 5.0

    }

    func createCardWithColor() {
        
        let width = scrollView.frame.width
        let height = scrollView.frame.height
        
        let x = CGFloat(scrollView.subviews.count) * width
        
        let view = UIView(frame: CGRect(x: x, y: 0, width: width - 20, height: height))
        view.backgroundColor = UIColor.blue
        
        view.layer.cornerRadius = 8.0
        
        scrollView.addSubview(view)
        scrollView.contentSize = CGSize(width: x + width, height: height)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        updateUI()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        updateUI()
    }

    func updateUI() {
        
        if scrollView.currentPage() >= scrollView.subviews.count - 1 {
            
            showPreviousButton()
        }
        else {
            
            showNextButton()
        }
    }
    
    func showNextButton() {
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            self.leftNextButtonConstraint.constant = 40
            self.view.layoutIfNeeded()
        }) 
    }
    
    func showPreviousButton() {
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            self.leftNextButtonConstraint.constant = -self.view.frame.width
            self.view.layoutIfNeeded()
        }) 

    }

}
