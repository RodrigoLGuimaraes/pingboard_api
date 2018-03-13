//
//  ViewController.swift
//  Feedbankers
//
//  Created by Rodrigo Longhi Guimarães on 13/03/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

enum State {
    case closed
    case open
    
    var opposite: State {
        return self == .open ? .closed : .open
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    let CLOSED_SIZE : CGFloat = 51
    
    //Array with all animators for the view
    var runningAnimators: [UIViewPropertyAnimator] = []
    
    //Current state of comments view
    var state: State = .closed
    
    var viewOffset: CGFloat = 300//TODO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
    }
    
    func animateIfNeeded(to state: State, duration: TimeInterval) {
        
        //if there is animators running, ignore
        guard runningAnimators.isEmpty else { return }
        
        //Creates a basic animator to take care of the states of the view
        let basicAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: nil)
        
        //Add animations to the animator
        //Related to view position, corner radius and icon alpha
        //Just use the desired value for each state (closed or open)
        basicAnimator.addAnimations {
            switch state {
            case .open:
                self.bottomViewConstraint.constant = 0
            case .closed:
                self.bottomViewConstraint.constant = self.bottomView.bounds.height - self.CLOSED_SIZE
            }
            self.view.layoutIfNeeded()
        }
        
        basicAnimator.addCompletion { position in
            self.runningAnimators.removeAll()
            self.state = self.state.opposite //change the current state to the opposite
        }
        
        runningAnimators.append(basicAnimator)
    }
    
    @objc func onDrag(_ gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            //create animations to desired state
            animateIfNeeded(to: state.opposite, duration: 0.4)
        case .changed:
            //calculates the percent of completion and sets it to all running animators
            let translation = gesture.translation(in: bottomView)
            let fraction = abs(translation.y / viewOffset)
            
            runningAnimators.forEach { animator in
                animator.fractionComplete = fraction
            }
        case .ended:
            //finish running animations to desired state
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
        default:
            break
        }
        
    }
    
    @objc func onTap(_ gesture: UITapGestureRecognizer) {
        //create animations and
        animateIfNeeded(to: state.opposite, duration: 0.4)
        runningAnimators.forEach { $0.startAnimation() }
        
    }
    
    func setupViews() {
        bottomViewConstraint.constant = bottomView.bounds.height - CLOSED_SIZE
        self.view.layoutIfNeeded()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.onDrag(_:)))
        self.bottomView.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:)))
        self.bottomView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

