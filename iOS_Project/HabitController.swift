//
//  HabitController.swift
//  iOS_Project
//
//  Created by Veena Balakumar on 27/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import Foundation

import UIKit

//var listOfHabits = ["Your habit 1", "Your habit 2"]
var listOfHabits = [Habit]()
var habitDes = ["bla bla bla", "heh.."]
var myIndex = 0


class HabitController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var titleOfHabit: UITextField!
    @IBOutlet weak var daysOfHabits: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    
//    @IBOutlet weak var titleOfHabit: UITextField!
//    @IBOutlet weak var myTableView: UITableView!
//    @IBOutlet weak var daysOfHabits: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listOfHabits.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = listOfHabits[indexPath.row].habitTitle
        cell.textLabel?.numberOfLines = 0
        
        
//        let image = UIImage(named: "checkBoxOUTLINE @2x")
//        cell.imageView!.image = image
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            listOfHabits.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped a habit")
        
        myIndex = indexPath.row
        
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    
    
    
    
    @IBAction func addItemButton(_ sender: UIButton) {
       
        if(titleOfHabit.text != "" && daysOfHabits.text != "")
            
            //&& Int(daysOfHabits.text!) = ""
        {
            var newHabit = Habit()
            newHabit.habitTitle = titleOfHabit.text!
            newHabit.daysOfHabit = Int(daysOfHabits.text!)!
            
            listOfHabits.append(newHabit)
            
            titleOfHabit.text = ""
            titleOfHabit.resignFirstResponder()
            
            daysOfHabits.resignFirstResponder()
            myTableView.reloadData()
            
        } else {
            
            let alertController = UIAlertController(title: "Error", message: "Please fill in the fields", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.estimatedRowHeight =  44
        myTableView.rowHeight = UITableView.automaticDimension
        
        /*
         var workOut = Habit()
         workOut.habitTitle = "Workout"
         workOut.daysOfHabit = 5
         
         var healthyEating = Habit()
         healthyEating.habitTitle = "Healthy Eating"
         healthyEating.daysOfHabit = 30
         
         listOfHabits.append(workOut)
         listOfHabits.append(healthyEating)
         */
        print(listOfHabits)
    }
    
}

