//
//  ViewController.swift
//  CoreDataSample
//
//  Created by Kap's on 22/06/20.
//  Copyright © 2020 Kapil. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var talbeView: UITableView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
            self.talbeView.reloadData()
        } catch {}
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Post", style: .default, handler: { (_) in
            
            let name = alert.textFields!.first!.text!
            let age = alert.textFields!.last!.text!
            
            let person = Person(context: PersistenceService.context)
            person.name = name
            person.age  = Int16(age)!
            
            PersistenceService.saveContext()
            
            self.people.append(person)
            self.talbeView.reloadData()
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].age)
        return cell
    }
}

