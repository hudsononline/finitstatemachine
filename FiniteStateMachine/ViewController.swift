//
//  ViewController.swift
//  FiniteStateMachine
//
//  Created by Qingyun Xiu on 3/19/18.
//  Copyright © 2018 Qingyun Xiu. All rights reserved.
//

import UIKit
import SwiftState


class ViewController: UIViewController {
    
    enum MyState: StateType {
        case locked, unlocked
    }
    
    enum MyEvent: EventType {
        case coin, push
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // setup state machine
        let machine = StateMachine<MyState, MyEvent>(state: .locked) { machine in
            
            // add locked => unlocked => unlocked
            machine.addRoutes(event: .coin, transitions: [
                .locked => .unlocked,
                .unlocked => .unlocked,
                ])
            
            // add unlocked => locked => locked
            machine.addRoutes(event: .push, transitions: [
                .unlocked => .locked,
                .locked => .locked,
                ])

            // add event handler
            machine.addHandler(event: .coin) { context in
                if (context.fromState == MyState.locked) {
                    print("=> unlocks the turnstile!")
                }
            }
            // add event handler
            machine.addHandler(event: .push) { context in
                if (context.fromState == MyState.unlocked) {
                    print("=> locks the turnstile!")
                }
            }
        }
        print("initial state: \(machine.state)")
        print("put a coint")
        machine <-! .coin
        print("push the arm")
        machine <-! .push
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

