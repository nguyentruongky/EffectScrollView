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
    
    @IBAction func loadPrevious(sender: AnyObject) {
        
        scrollView.loadPreviousPage(true)
    }
    
    @IBAction func loadNext(sender: AnyObject) {
        
        scrollView.loadNextPage(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func changeEffect(sender: AnyObject) {

        var animation = AnimationType.None
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            animation = AnimationType.Cards

        case 1:
            animation = AnimationType.Carousel
        
        case 2:
            animation = AnimationType.Depth
        
        case 3:
            animation = AnimationType.Translation
            
        default:
            break
        }
        
        scrollView.effect = animation
        scrollView.setEffect(animation)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.scrollView.effect = AnimationType.Carousel
        
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
        
        let width = CGRectGetWidth(scrollView.frame)
        let height = CGRectGetHeight(scrollView.frame)
        
        let x = CGFloat(scrollView.subviews.count) * width
        
        let view = UIView(frame: CGRectMake(x, 0, width - 20, height))
        view.backgroundColor = UIColor.blueColor()
        
        view.layer.cornerRadius = 8.0
        
        scrollView.addSubview(view)
        scrollView.contentSize = CGSizeMake(x + width, height)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        updateUI()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
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
        
        UIView.animateWithDuration(0.3) { () -> Void in
            
            self.leftNextButtonConstraint.constant = 40
            self.view.layoutIfNeeded()
        }
    }
    
    func showPreviousButton() {
        
        UIView.animateWithDuration(0.3) { () -> Void in
            
            self.leftNextButtonConstraint.constant = -CGRectGetWidth(self.view.frame)
            self.view.layoutIfNeeded()
        }

    }

}
