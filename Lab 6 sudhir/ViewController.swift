//
//  ViewController.swift
//  Lab 6 sudhir
//
//  Created by user240106 on 2/19/24.
//

import UIKit

class ViewController: UIViewController {
    var items = [String]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedData = UserDefaults.standard.array(forKey: "items") as? [String] {
        items = savedData
        }
        table.delegate = self
        table.dataSource = self
    }
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default){(cancel) in
            
        }
        let save = UIAlertAction(title: "Ok", style: .default){(save) in
            
            self.items.append(textField.text!)
            self.table.reloadData()
            UserDefaults.standard.set(self.items, forKey: "items")
            
        }
        
        alert.addTextField { (text) in
            textField = text
            textField.placeholder = "Add New Item"
        }
        alert.addAction(cancel)
        alert.addAction(save)
        
        self.present(alert, animated: true, completion : nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    items.remove(at: indexPath.row)
                    self.table.reloadData()
                    UserDefaults.standard.set(items, forKey: "items")
                    
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier :"cell" , for : indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
}
