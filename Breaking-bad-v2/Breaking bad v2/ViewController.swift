//
//  ViewController.swift
//  breaking bad project
//
//  Created by Nick Chiloane on 2021/07/10.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    var characterDeats = [Character]()
    var quoteDeats = [Quote]() //Contains all quotes
    var filteredQuotes = [Quote]()// Contains one characters' quotes
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterDeats.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! customUITableViewCell
        
        
        cell.actorName?.text =   characterDeats[indexPath.row].name.uppercased()
        cell.actorNickname?.text = characterDeats[indexPath.row].nickname.uppercased()
        cell.dob?.text = characterDeats[indexPath.row].dob.uppercased()
        cell.actorImg.downloaded(from: characterDeats[indexPath.row].img)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "showCharacterDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destination = segue.destination as? ViewControllerCharacter
        {
            destination.theCharacter = characterDeats[(tableView.indexPathForSelectedRow?.row)!]
            destination.characterQuotes = returnCharacterQuote(characterDeats[(tableView.indexPathForSelectedRow?.row)!].name)
        }
    }
    
    func returnCharacterQuote(_ characterName: String) -> [Quote]
        {
            
            
            filteredQuotes = quoteDeats.filter
            {
                $0.author.elementsEqual(characterName)
            }
            
           return filteredQuotes
           
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadCharacterJSON {
            self.downloadQuoteJSON {
                print("All quotes have been downloaded")
            }
            print("charactors are downloaded")
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }

    func downloadCharacterJSON(completed: @escaping () -> ())
        {
            
            //let urlComponents = URLComponents()
            //urlComponents.pa


            let url = URL(string: "https://www.breakingbadapi.com/api/characters?limit=15")!
            let urlSession = URLSession.shared
            let urlRequest = URLRequest(url: url)

            let task = urlSession.dataTask(with: urlRequest)
            {
                data, urlResponse, error in
                
                if let error = error
                {
                    
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let unwrappedData = data else
                {
                    print("No data")
                    return
                }
                
                
                let jsonDecoder = JSONDecoder()
                do
                {
                    guard let characterList = try? jsonDecoder.decode([Character].self, from: unwrappedData) else
                    {
                        print("Could not decode")
                        return
                    }
                    DispatchQueue.main.async
                    {
                        completed()
                    }
                    print(characterList)
                    self.characterDeats = characterList
                }
            }.resume()
        }
    
    func downloadQuoteJSON(completed: @escaping () -> ())
        {
            
            //let urlComponents = URLComponents()
            //urlComponents.pa


            let url = URL(string: "https://www.breakingbadapi.com/api/quotes")!
            let urlSession = URLSession.shared
            let urlRequest = URLRequest(url: url)

            let task = urlSession.dataTask(with: urlRequest)
            {
                data, urlResponse, error in
                
                if let error = error
                {
                    
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let unwrappedData = data else
                {
                    print("No data")
                    return
                }
                
                
                let jsonDecoder = JSONDecoder()
                do
                {
                    guard let quoteList = try? jsonDecoder.decode([Quote].self, from: unwrappedData) else
                    {
                        print("Could not decode the Quotes")
                        return
                    }
                    DispatchQueue.main.async
                    {
                        completed()
                    }
                    print(quoteList)
                    self.quoteDeats = quoteList
                }
            }.resume()
        }

}

