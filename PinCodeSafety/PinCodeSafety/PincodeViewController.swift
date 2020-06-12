//
//  PincodeViewController.swift
//  PinCodeSafety
//
//  Created by Scott Lydon on 6/12/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import UIKit


class UserClass: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pincodeViewController = PincodeViewController()
        pincodeViewController.show(
            deleted: { incorrectKey in
                
            },inputted: { keyInputted in
                
            }, completed: { success in
                
            }
        )
        
        // present the pincode.
        //     initialize the model for it
        //    send to the view
        //
        
        //
        // priavate interface touch pin
        // private  interface to delete
        //
    }
}

class PincodeViewController: UIViewController {
    
    typealias IntAction = (Int) -> Void
    var pinViewModel: PinViewModel?
    var expectedPins: [Int] = []
    
    fileprivate var deleted: IntAction?
    fileprivate var inputted: IntAction?
    fileprivate var completed: PinViewModel.CompletedAction?
    
    func show(
        deleted: @escaping IntAction,
        inputted: @escaping IntAction,
        completed: @escaping PinViewModel.CompletedAction
    ) {
        self.deleted = deleted
        self.inputted = inputted
        self.completed = completed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pinViewModel = PinViewModel(expectedPins: self.expectedPins)
        pinViewModel?.touchedPinsChanged = { [weak self] pins in
            // display pins.count in top bubbles
        }
    }

    @IBAction func send(key: Int) {
        inputted?(key)
        self.pinViewModel?.add(pin: key)
        guard let pinViewModel = pinViewModel else {
            assertionFailure("Please provide a pinViewModel before manipulating the pinView")
            return
        }
        if pinViewModel.expectedPins.count == expectedPins.count {
            if pinViewModel.expectedPins == expectedPins {
                completed?(.success)
            } else {
                
            }
        }
    }    
}

public struct PinViewModel {
    
    typealias CompletedAction = (Completed) -> Void
    typealias PinsAction = ([Int]) -> Void
    
    init(expectedPins: TouchedPins, touchedPins: TouchedPins = [], pinCountLimit: Int = 6) {
        self.expectedPins = expectedPins
        self.touchedPins = touchedPins
        self.pinCountLimit = pinCountLimit
    }
    
    enum Completed {
        case success, fail, leave
    }
    
    var touchedPinsChanged: PinsAction?

    var expectedPins: TouchedPins
    var touchedPins: TouchedPins
    var pinCountLimit: Int
    
    mutating func add(pin: Int) {
        if touchedPins.count < pinCountLimit {
            touchedPins.append(pin)
        }
    }
    
    mutating func delete(pin: Int) {
        touchedPins.removeLast()
    }
}


typealias TouchedPins = [Int]

typealias Pins = [[Bool]]

extension Array where Element == [Bool] {

}
