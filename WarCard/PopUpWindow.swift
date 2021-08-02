//
//  PopUpWindow.swift
//  WarCard
//
//  Created by UWICIIT-Admin on 2020/3/8.
//  Copyright © 2020 UWICIIT-Admin. All rights reserved.
//

import UIKit

protocol PopUpDelegate {
    func handleDismissal()
}


class PopUpWindow: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance duringdd animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //Tevin: - Properties
        var delegate: PopUpDelegate?
    
   //variable to store winner and or looser
    var playerWins: Bool?{
        didSet{
            guard let success = playerWins else { return}
                
                if success{
                    checkLabel.text = "Player you're the WINNER! "
                    someImageView.image = UIImage(named: "winlogo.png")
                    someImageView.frame = CGRect(x: 100, y: 100, width: 200, height: 150)
                }else{
                    checkLabel.text = "Player you TIED/LOST "
                    someImageView.image = UIImage(named: "loselogo.png")
                    someImageView.frame = CGRect(x: 100, y: 100, width: 200, height: 150)
                }
            }
        }
    
    //Label for pop up view
    let checkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size:20)
        label.textColor = .systemGreen
        return label
    }()
    
    //image for pop up view
      let someImageView: UIImageView = {
         let theImageView = UIImageView()
         let screenSize: CGRect = UIScreen.main.bounds
         theImageView.frame = CGRect(x: 50, y: 100, width: 200, height: 150)
         theImageView.contentMode = .scaleAspectFill
         theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
         return theImageView
      }()
    
    //Button for pop up view
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,action: #selector(handleDismissal), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 30)
        return button
    }()
    
    //Tevin: - Init
    override init (frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .white
       
          
        addSubview(checkLabel)
        checkLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -120).isActive = true
        checkLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
       
        addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
             
        
        addSubview(someImageView)
        someImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        someImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        someImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        someImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
      
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //Tevin: - Selectors
    @objc func handleDismissal(){
        delegate?.handleDismissal()
    }

}
