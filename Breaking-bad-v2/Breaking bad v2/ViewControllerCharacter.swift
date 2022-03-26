//
//  ViewControllerCharacter.swift
//  Breaking bad v2
//
//  Created by Nick Chiloane on 2021/07/14.
//

import UIKit

class ViewControllerCharacter: UIViewController {

    @IBOutlet weak var NameAndSurname: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var apperence: UILabel!
    @IBOutlet weak var actorImg: UIImageView!
    @IBOutlet weak var quotes: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var theCharacter: Character?
    var characterQuotes = [Quote]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let charactorAppearances: [Int] = (theCharacter?.appearance)!
        let stringCharactorAppearances = charactorAppearances.map { String($0) }
        apperence.text = " Seasons \(stringCharactorAppearances.joined(separator: ", "))"
        
        actorImg.downloaded(from: (theCharacter?.img)!)
        NameAndSurname.text = "Name: \(theCharacter!.name)"
        nickname.text = "Nick Name: \(theCharacter!.nickname)"
        status.text = "Status: \(theCharacter!.status)"
        
        let theStatus = theCharacter?.status
        
        if theStatus == "Alive"
        {
            status.textColor = UIColor.green
        }
        else
        {
            status.textColor = UIColor.red
        }
        
        quotes.text = ""
        
        for i in 0 ..< characterQuotes.count
        {
            quotes.text?.append("\(characterQuotes[i].quote) \n\n")
        }
    }
    


}
