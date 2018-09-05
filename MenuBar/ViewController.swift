//
//  ViewController.swift
//  MenuBar
//
//  Created by zyad on 9/5/18.
//  Copyright © 2018 zyad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //segment contbrol
    @IBOutlet weak var segmentControlView: UIView!
    @IBOutlet weak var mainView: UIView!
    var firstView : UIViewController?
    var secondView : UIViewController?
    let buttonBar = UIView()
    let segmentedControl = UISegmentedControl()
    //------------------
    func SegmentControl()
    {
        //shadow for view
        segmentControlView.layer.shadowOpacity = 0.3
        segmentControlView.layer.shadowRadius = 2.0
        segmentControlView.layer.shadowOffset = CGSize(width: 1.0, height: 5.0)
        segmentControlView.layer.masksToBounds = false
        // Add segments
        self.segmentedControl.insertSegment(withTitle: "first view", at: 0, animated: true)
        self.segmentedControl.insertSegment(withTitle: "second view", at: 1, animated: true)
        
        // First segment is selected by default
        self.segmentedControl.selectedSegmentIndex = 0
        
        //constraints
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // Add the segmented control to the container view
        self.segmentControlView.addSubview(self.segmentedControl)
        // Constraint of segment control in the view
        self.segmentedControl.topAnchor.constraint(equalTo:  segmentControlView.topAnchor).isActive = true
        self.segmentedControl.widthAnchor.constraint(equalTo:  segmentControlView.widthAnchor).isActive = true
        self.segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //clear backgroud color
        self.segmentedControl.backgroundColor = .clear
        self.segmentedControl.tintColor = .clear
        //change color and font
        //when not selected
        self.segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "Arial", size: 13)!,
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        //when selected
        self.segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "Arial", size: 13)!,
            NSAttributedStringKey.foregroundColor: UIColor.red
            ], for: .selected)
        
        //button bar
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor.red
        segmentControlView.addSubview(buttonBar)
        // Constraint
        //------------------
        // it will appear in bottom
        buttonBar.bottomAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor).isActive = true
        //it will appear in top
            //buttonBar.topAnchor.constraint(equalTo: self.segmentedControl.topAnchor).isActive = true
        //--------------
        buttonBar.heightAnchor.constraint(equalToConstant: 3).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: self.segmentedControl.widthAnchor, multiplier: 1 / CGFloat(self.segmentedControl.numberOfSegments)).isActive = true
        
        //add childs to move between view controllers
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        firstView = storyboard.instantiateViewController(withIdentifier: "firstView")
        firstView?.view.frame = CGRect(x: 0, y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
        addChildViewController(firstView!)
        secondView = storyboard.instantiateViewController(withIdentifier: "secondView")
        secondView?.view.frame = CGRect(x: 0, y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
        addChildViewController(secondView!)
        //add child view controllers to the parent
        self.mainView.addSubview(secondView!.view)
        self.mainView.addSubview(firstView!.view)
        //animation when another tab clicked
        self.segmentedControl.addTarget(responds, action: #selector(segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }
        if segmentedControl.selectedSegmentIndex == 0
        {
            firstView?.view.isHidden = false
            secondView?.view.isHidden = true
        }
        else
        {
            firstView?.view.isHidden = true
            secondView?.view.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SegmentControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

