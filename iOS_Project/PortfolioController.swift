//
//  PortfolioController.swift
//  iOS_Project
//
//  Created by Veena Balakumar on 26/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit

class PortfolioController: UIViewController {
    
    @IBOutlet weak var scrollViewImage: UIScrollView!
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Loads saved images from persistence
        let images = coreData().loadImage()
        
        addImageToScrollView(imageArray: images)
        
    }
    
    //The method adds the images loaded to the scrollView
    func addImageToScrollView(imageArray: [UIImage]) {
        
        for i in 0..<imageArray.count {
            
            //Defines the size of the imageView
            let imageView = UIImageView()
            let y = self.view.frame.size.height * CGFloat(i)
            imageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            //sets the loaded image to the imageView
            imageView.image = imageArray[i]
            
            //sets the size of the scrollview
            scrollViewImage.contentSize.height = scrollViewImage.frame.size.height * CGFloat(i+1)
            
            //adds the imageview to the scrollview
            scrollViewImage.addSubview(imageView)
        }
    }
    
    
}
