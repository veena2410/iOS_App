//
//  coreData.swift
//  iOS_Project
//
//  Created by Veena Balakumar on 21/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class coreData {
    
    let context: NSManagedObjectContext
    
    init() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.context = appDelegate!.persistentContainer.viewContext
    }
    
    func getContext() -> NSManagedObjectContext {
    
        return self.context
    }
    
    
    func saveImage(image: UIImage) {
        
        let date : Double = NSDate().timeIntervalSince1970
        
        let imageData = image.pngData()
        
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: self.context)
        
        let entityObj = NSManagedObject(entity: entity!, insertInto: self.context)
        
        entityObj.setValue(imageData, forKey: "image")
        entityObj.setValue(date, forKey: "id")
        
        
        
        do{
            try self.context.save()
            
        }catch {
            fatalError("fail to save image!")
        
        }
        
    }
    
    func loadImage(view: UIImageView) -> Void {
        
        
        let fetchImage = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        
        do{
            
            let results = try self.context.fetch(fetchImage)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let imageData = result.value(forKey: "image") as? Data {
                        if let image = UIImage(data: imageData){
                            view.image = image
                        }
                    }
                }
            }
            
            
        }catch{
            
            print("could not fetch image: ")
        }
        
        
    }
    
   
    func SaveToDo(name: String, entityName: String) {
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: coreData().context)!
        
        let todo = NSManagedObject(entity: entity, insertInto: self.context)
        
        todo.setValue(name, forKey: "name")
        
        do{
            try self.context.save()
            
        }catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func loadToDo(entityName: String) -> [String] {
        
        var list: [String] = []
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do{
            
            let results = try self.context.fetch(fetchRequest)
            
            if(results.count > 0) {
                for result in results as [NSManagedObject] {
                
                    if let todo = result.value(forKey: "name") as? String {
                    
                        list.append(todo)
                    }
                }
            }
            
        }catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
        
        return list
    }
    
    func deleteToDo(name: String, entityName: String) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do{
            let results = try self.context.fetch(fetchRequest)
            
            if(results.count > 0) {
                for result in results as [NSManagedObject] {
                    
                    let todo = result.value(forKey: "name") as? String
                    
                    if todo==name {
                        
                        self.context.delete(result)
                    }
                }
            }
            
            try self.context.save()
            
        }catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
    
    }
    
    
    

}
