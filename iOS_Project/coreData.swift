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
    
    
    func saveImage(image: UIImage) {
        
        let date : Double = NSDate().timeIntervalSince1970
        
        let imageData = image.pngData()
        
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: self.context)
        
        let entityObj = NSManagedObject(entity: entity!, insertInto: self.context)
        
        entityObj.setValue(imageData, forKey: "image")
        entityObj.setValue(date, forKey: "id")
        
        
        //let concurrency = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
        
        //let moc = NSManagedObjectContext(concurrencyType: concurrency)
        
       // let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: moc) as? Photo
        
         //   photo?.image = imageData
         //   photo?.id = date
        
        
        do{
            try self.context.save()
            
        }catch {
            fatalError("fail to save image!")
        
        }
        
       // moc.refreshAllObjects()
        
    }
    
    func loadImage(view: UIImageView) -> Void {
        
       // let concurrency = NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType
        
      //  let moc = NSManagedObjectContext(concurrencyType: concurrency)
        
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
}
