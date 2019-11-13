//
//  AddBlogViewController.swift
//  Millionare
//
//  Created by Michael Chan on 13/11/2019.
//  Copyright © 2019 EE4304. All rights reserved.
//

import UIKit

class AddBlogViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBAction func Exit(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet var blogtitleInput: UITextField!
    @IBOutlet var blogcontentInput: UITextView!
    @IBOutlet var blogIcon: UIImageView!
    
    @IBAction func uploadphoto(_ sender: Any) {
     //   let image = UIImagePickerController()
      //  image.delegate = self
       // image.sourceType = UIImagePickerController.SourceType.photoLibrary
       // image.allowsEditing = true
       // self.present(image,animated:true){}
       
             let imagePickerController = UIImagePickerController()
        
             
             imagePickerController.delegate = self
        
            
             let imagePickerAlertController = UIAlertController(title: "Image Upload", message: "Please select the image to upload", preferredStyle: .actionSheet)
        
            
             let imageFromLibAction = UIAlertAction(title: "Gallery", style: .default) { (Void) in
        
               
                 if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        
                     
                     imagePickerController.sourceType = .photoLibrary
                     self.present(imagePickerController, animated: true, completion: nil)
                 }
             }
             let imageFromCameraAction = UIAlertAction(title: "Camera", style: .default) { (Void) in
        
                 
                 if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
                     
                     imagePickerController.sourceType = .camera
                     self.present(imagePickerController, animated: true, completion: nil)
                 }
             }
        
             
             let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (Void) in
        
                 imagePickerAlertController.dismiss(animated: true, completion: nil)
             }
        
             
             imagePickerAlertController.addAction(imageFromLibAction)
             imagePickerAlertController.addAction(imageFromCameraAction)
             imagePickerAlertController.addAction(cancelAction)
        
             
             present(imagePickerAlertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func submit(_ sender: Any) {
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            blogIcon.image = image
            
        }else{
            
            
        }
        self.dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
