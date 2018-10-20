//
//  BulletJournalController.swift
//  iOS_Project
//
//  Created by Veena Balakumar on 20/10/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit

class BulletJournalController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var myTableView: UITableView!

    
    var list = ["Your goal", "Your goal2"]

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            list.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        if(input.text != "")
        {
            list.append(input.text!)
            input.text = ""
            input.resignFirstResponder()
            myTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

