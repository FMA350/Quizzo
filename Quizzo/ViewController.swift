//
//  ViewController.swift
//  Quizzo
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 08/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //CONSTANTS
    let MAX_LINES: Int = 4
    let BUTTON_TRUE: Int = 1
    let BUTTON_FALSE: Int = 0
    let QUESTION: [String] = ["George W. Bush won the presidential primaries of 2004", "Ferruccio Lamborghini started his company building tractors", "There are more grains of sands in our beaches than stars in the sky", "The solar system is composed also by 4 rocky planets", "The speed of light does not slow down ever", "If we all jumped at the same time, we would be able to move the Earth's orbit by circa 1.5 inches!", "Although we cannot view the objects themselves, we can draw and picture the shadow of 4 dimensional objects"]
    let ANSWER:[Bool] = [true, true, false, true, false, false, true]
    


    //UI components
    let buttonTrue = UIButton(type: .system)
    let buttonFalse = UIButton(type: .system)
    let questionLabel = UILabel()
    let scoreLabel = UILabel()
    let questionCounterLabel = UILabel()
    let completionBar = UILabel()

    //Quiz Variables
    var questionNumber: Int = 0
    var score: Int = 0
    //screen size variables
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Creating buttons + questionLabel programmatically
        screenWidth =  self.view.frame.size.width
        screenHeight = self.view.frame.size.height
        questionLabel.textAlignment = .center
        frameBuilder(element: buttonTrue, xper: 0.1, yper: 0.6, wper: 0.35, hper: 0.1)
        frameBuilder(element: buttonFalse, xper: 0.55, yper: 0.6, wper: 0.35, hper: 0.1)
        frameBuilder(element: questionLabel, xper: 0.1, yper: 0.1, wper: 0.8, hper: 0.45)
        frameBuilder(element: completionBar, xper: 0, yper: 0.95, wper: 1/7, hper: 0.05)
        frameBuilder(element: questionCounterLabel, xper: 0.05, yper: 0.8, wper: 0.3, hper: 0.1)
        frameBuilder(element: scoreLabel, xper: 0.75, yper: 0.8, wper: 0.2, hper: 0.1)
        
        questionCounterLabel.numberOfLines = 0
        
        buttonTrue.backgroundColor = UIColor(displayP3Red: 118/255, green: 232/255, blue: 149/255, alpha: 1)
        buttonFalse.backgroundColor  = UIColor(displayP3Red: 255/255, green: 87/255, blue: 48/255, alpha: 1)
        questionLabel.backgroundColor = UIColor(displayP3Red: 118/255, green: 194/255, blue: 232/255, alpha: 0.8)
        completionBar.backgroundColor = .yellow
        
        buttonTrue.tag = BUTTON_TRUE
        buttonFalse.tag = BUTTON_FALSE
        
        
        buttonTrue.setTitle("True", for: .normal)
        buttonFalse.setTitle("False", for: .normal)
        
        
        buttonTrue.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonFalse.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
        questionLabel.numberOfLines = MAX_LINES
        
        questionCounterLabel.text = "Question \(questionNumber+1) /7"
        scoreLabel.text = "Score: \(score)"
        self.view.addSubview(questionLabel)
        self.view.addSubview(buttonTrue)
        self.view.addSubview(buttonFalse)
        self.view.addSubview(questionCounterLabel)
        self.view.addSubview(scoreLabel)
        self.view.addSubview(completionBar)

        loadQuestion();
    }
    
    
  @objc func buttonTapped(sender: AnyObject){
        if(sender.tag == BUTTON_TRUE){
            checkAnswer(value: true)
        }
        else if(sender.tag == BUTTON_FALSE){
            checkAnswer(value: false)
        }
        nextQuestion();
    }
    
    func nextQuestion(){
        if(questionNumber >= QUESTION.count-1){
           let alert = UIAlertController(title: "\(score)/7, Well done!", message: "If you enjoyed this quiz, consider rating us on the App Store!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: {action in
                self.resetQuiz()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            questionNumber += 1
            updateLabels()
        }
    }

    func checkAnswer(value: Bool){
        if(value == ANSWER[questionNumber]){
            score += 1
            updateLabels()
        }
    }
    
    func resetQuiz(){
        score = 0
        questionNumber = 0
        updateLabels()
    }
    
    func updateLabels(){
        completionBar.frame.size.width = (screenWidth/7)*CGFloat(questionNumber+1)
        scoreLabel.text = "Score: \(score)"
        questionCounterLabel.text = "Question \(questionNumber+1) /7"
        questionCounterLabel.sizeToFit()
        loadQuestion()
    }
    
    func loadQuestion(){
        questionLabel.text = QUESTION[questionNumber]
    }
    
    func frameBuilder(element: UIView, xper:CGFloat, yper:CGFloat, wper:CGFloat, hper:CGFloat){
        element.frame = CGRect(x: screenWidth*xper, y: screenHeight*yper, width: screenWidth*wper, height: screenHeight*hper)
    }
}

