//
//  ViewController.swift
//  RetroCalculator
//
//  Created by C Mayank Dogra on 11/06/17.
//  Copyright © 2017 C Mayank Dogra. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
   
    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    
    var runningNumber = ""
    
    var leftSideValue = ""
    
    var rightSideValue = ""
    
    var resultValue = ""
    
    
    @IBAction func numPressed(_ sender: UIButton) {
        
        playSound()
        
        runningNumber += "\(sender.tag)"
        
        outputLabel.text = runningNumber
        
    }
    
    
    func playSound(){
        
        if btnSound.isPlaying{
        
            btnSound.stop()
        
        }
        
        btnSound.play()
    
    }
    
    
    @IBAction func dividePressed(sender: AnyObject){
    
        processOperation(operation: .Divide)
        
    }
    
    
    @IBAction func multiplyPressed(sender: AnyObject){
        
        processOperation(operation: .Multiply)
        
    }
    
    
    @IBAction func addPressed(sender: AnyObject){
        
        processOperation(operation: .Add)
        
    }
    
    
    @IBAction func subtractPressed(sender: AnyObject){
        
        processOperation(operation: .Subtract)
        
    }
    
    
    @IBAction func equalPressed(sender: AnyObject){
    
        processOperation(operation: currentOperation)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            
            btnSound.prepareToPlay()
        
        }catch let err as NSError{
            
            print(err.debugDescription)
       
        }
        
        outputLabel.text = ""

    }
    
    func processOperation(operation: Operation){
        
        playSound()
    
        if currentOperation != Operation.Empty{
        
            if runningNumber != ""{
            
                rightSideValue = runningNumber
                
                runningNumber = ""
            
                if currentOperation == Operation.Divide{
                    
                    resultValue = "\(Double(leftSideValue)! / Double(rightSideValue)!)"
                
                }else if currentOperation == Operation.Multiply{
                
                    resultValue = "\(Double(leftSideValue)! * Double(rightSideValue)!)"
                    
                }else if currentOperation == Operation.Add{
                    
                    resultValue = "\(Double(leftSideValue)! + Double(rightSideValue)!)"
                    
                }else if currentOperation == Operation.Subtract{
                    
                    resultValue = "\(Double(leftSideValue)! - Double(rightSideValue)!)"
                    
                }
                
                leftSideValue = resultValue
                
                outputLabel.text = resultValue
            }
            
            currentOperation = operation
            
        }
        
        else{
        
            leftSideValue = runningNumber
            
            runningNumber = ""
            
            currentOperation = operation
            
        }
        
    }

}
