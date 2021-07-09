//
//  MyViewController.swift
//  MVC
//
//  Created by Muna Abdelwahab on 7/9/21.
//

import UIKit

class MyViewController: UIViewController {

    var personArray:[Person] = [Person]()
    var homeView : MyView! {
        guard isViewLoaded else {
            return nil
        }
        return view as? MyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        let url = URL(string: "https://learnappmaking.com/ex/users.json")
        guard let ValidateUrl = url else{
            return
        }
        let session = URLSession.shared.dataTask(with: ValidateUrl) { [self] (data, response, error) in
            guard let returnedData = data else{
                return
            }
            let decoder = JSONDecoder()
            do{
                self.personArray = try decoder.decode([Person].self, from: returnedData)
                print(personArray)
                DispatchQueue.main.async {
                self.homeView.tableView.reloadData()
                }
            }catch{
                print("Error\(error.localizedDescription)")
            }
        }
        session.resume()
    }
}

extension MyViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyViewController", for: indexPath)
        cell.textLabel?.text = personArray[indexPath.row].first_name
        cell.detailTextLabel?.text = String(personArray[indexPath.row].age)
        return cell
    }
    
    
}
