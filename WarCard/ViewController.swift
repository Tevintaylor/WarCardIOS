//
//  ViewController.swift
//  WarCard
//
//  Created by UWICIIT-Admin on 2020/3/7.
//  Copyright © 2020 UWICIIT-Admin. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    var audioPlayer:AVAudioPlayer?
    
    
    lazy var popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.delegate = self as? PopUpDelegate
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBOutlet weak var leftimageView: UIImageView!
    @IBOutlet weak var rightimageView: UIImageView!
    @IBOutlet weak var leftscoreLabel: UILabel!
    @IBOutlet weak var rightscoreLabel: UILabel!
    @IBOutlet weak var Ties: UILabel!
    
    var buttonTappedCount = 0
    var leftScore = 0
    var rightScore = 0
    var tiesScore = 0

    var sucess = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Blur the screen for the dialog pop up
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        
//        hide the visual blur
        visualEffectView.alpha = 0
        
    }

    @IBAction func dealTapped(_ sender: Any) {
        buttonTappedCount += 1
        
        if (buttonTappedCount < 16){
            Deal()
        }else{
            
             Display_Winner()
        }
    }
    
    func Deal(){
               // play sound
               playsound (nameFile: "deal",typeFile: "mp3")
                  
               //generate a random number for left card
               let leftNumber = Int.random(in: 2...14)
               
               //generate a random number for right card
               let rightNumber = Int.random(in: 2...14)
               
               
               //checks if the card played i greter on the left or right
               if leftNumber > rightNumber{
                   playsound (nameFile: "win_card",typeFile: "mp3")
                   leftScore += 1
                   leftscoreLabel.text = String(leftScore)
               }else if leftNumber < rightNumber{
                   playsound (nameFile: "loose_card",typeFile: "mp3")
                   rightScore += 1
                   rightscoreLabel.text = String(rightScore)
               }else{
                   playsound (nameFile: "tie",typeFile: "mp3")
                   tiesScore += 1
                   Ties.text = String(tiesScore)
               }
               
               print(buttonTappedCount)
               
               
               leftimageView.image = UIImage(named: "card\(leftNumber)")
               
               rightimageView.image = UIImage(named: "card\(rightNumber)")
    }
    
    //function to play sounds based and name and type of file
    
    func playsound (nameFile: String ,typeFile: String){
        //getting thr url
        let url = Bundle.main.url(forResource: nameFile, withExtension: typeFile)
               
        //Make sure that we've got the url, otherwise abord
        guard url != nil else {
            return
        }
               
        //create audio player and play the sound
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
                audioPlayer?.play()
        }catch{
                print("error")
        }
    }
    
    //    function to set winner nformation on the pop up view
    func Display_Winner(){
        if leftScore > rightScore{
             // play sound
             playsound (nameFile: "win",typeFile: "mp3")
             sucess = true
             print ("Player Wins")
             handleShowPopUp()
        }else if leftScore < rightScore{
             // play sound
             playsound (nameFile: "loose",typeFile: "mp3")
             sucess = false
             print("CPU Wins")
             handleShowPopUp()
        }else{
             // play sound
             playsound (nameFile: "win_card_two",typeFile: "mp3")
             sucess = false
             print("you tied")
             handleShowPopUp()
        }
    }
    
    @objc func handleShowPopUp(){
        // Do any additional setup after loading the view.
        view.addSubview(popUpWindow)
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popUpWindow.playerWins  = sucess
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        //Code to add animation to the pop up
        UIView.animate(withDuration: 0.5){
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
        }

    }
    
}

extension ViewController: PopUpDelegate{
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.buttonTappedCount = 0
            self.leftScore = 0
            self.rightScore = 0
            self.tiesScore = 0
            self.leftscoreLabel.text = String(0)
            self.rightscoreLabel.text = String(0)
            self.Ties.text = String(0)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop view...")
        }
    }
}
