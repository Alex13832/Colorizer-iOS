//
//  ViewController.swift
//  Colorizer_iOS
//
//  Created by Alexander Karlsson on 2019-12-30.
//  Copyright © 2019 Alexander Karlsson. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var colorizeButton: UIBarButtonItem!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    var imageColor: UIImage!
    var imageGray: UIImage!
    let colorizer = ImageUtilsWrapper();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /**
     Reacts when user taps on the screen, this will trigger opening the camera roll.
     - parameter sender: Any
     */
    @IBAction func onTap(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    /**
     Reacts when the arrow-button is pressed. This will call functions (in Objectiv-C++) to colorize the chose image.
     - parameter sender: UIBarButtonItem
     */
    @IBAction func onColorizeSwap(_ sender: UIBarButtonItem) {
        let image:UIImage = imageView.image!
        let colorIm = colorizer.colorizeImage(image)
        
        imageView.image = colorIm;
        imageColor = colorIm
        
        segment.isEnabled = true
        segment.isHidden = false
        actionButton.isEnabled = true
        colorizeButton.isEnabled = false
    }
    
    /**
     Goes between the colorized image and the grayscale input image, to compare.
     - parameter sender: UISegmentedControl
     */
    @IBAction func onSegmentChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            imageView.image = imageColor
            actionButton.isEnabled = true
        } else if sender.selectedSegmentIndex == 1 {
            imageView.image = imageGray
            actionButton.isEnabled = false
        }
    }
    
    /**
     Reacts when the action button is pressed, this whill open the "share" menu where the user can chose to e.g. save the result.
     - parameter sender: UIBarButtonItem
     */
    @IBAction func onActionButtonPressed(_ sender: UIBarButtonItem) {
        if let image = imageColor {
            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            present(vc, animated: true)
        }
    }
    
    /**
     Opens the camera roll and gets the selected image.
     - parameter picker: UIImagePickerController
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            imageView.image = image
            imageGray = image
        }
        
        segment.isHidden = true
        segment.isEnabled = false
        actionButton.isEnabled = false
        colorizeButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
     Listens for dismiss of camera roll.
     - parameter picker: UIImagePickerController
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
