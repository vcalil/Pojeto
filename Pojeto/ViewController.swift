//
//  ViewController.swift
//  Pojeto
//
//  Created by Galil on 28/06/21.
//

import UIKit

class LabelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //@IBOutlet weak var label: UILabel!
    @IBOutlet weak var table: UITableView!
    
    let technoDJ: [String] = ["Mathame", "ArtBat", "Boris", "Adriatique"]
    
    var drinks: [Drink] = []
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //label.text = loadTitle()
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // Do any additional setup after loading the view.
        table.bounces = true
        table.delegate = self
        table.dataSource = self
        requestApi()
    }

    //func loadTitle() -> String {
     //   return "boludo"
    //}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(drinks.count)
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.table.dequeueReusableCell(withIdentifier: cellReuseIdentifier){
            
            
            //cell.textLabel?.text = self.technoDJ[indexPath.row]
            cell.textLabel?.text = drinks[indexPath.row].strDrink
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //print("You tapped cell number \(indexPath.row).")
        
    }
    
    func requestApi(){
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in guard let data = data else {return}
            print("The response is: ",String(data: data, encoding: .utf8)!)
            
            
            let drinksContainer = try! JSONDecoder().decode(DrinksContainer.self, from: data)
            self.drinks = drinksContainer.drinks
            print(self.drinks[0].strDrink)
            //let json = try! JSONSerialization.data(withJSONObject: data, options: [])
            //let jsonDict = json as? NSDictionary
            //let name = jsonDict?["strDrink"] as? String
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
            
        }
        task.resume()
    }

}

struct Drink: Codable {
    let strDrink: String
}

struct DrinksContainer: Codable {
    let drinks: [Drink]
}
