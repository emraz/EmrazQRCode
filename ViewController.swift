//
//  ViewController.swift
//  EmrazQRCode
//
//  Created by Mahmudul Hasan R@zib on 4/18/17.
//  Copyright © 2017 Mahmudul Hasan R@zib. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    
    var qrcodeImage: CIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generateButtonACtion(_ sender: Any) {
        
        if qrcodeImage == nil {
            if inputTextField.text == "" {
                return
            }
            
            let data = inputTextField.text!.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter?.outputImage
            
            inputTextField.resignFirstResponder()
            
            generateButton.setTitle("Clear", for: UIControlState())
            
            displayQRCodeImage()
        }
        else {
            inputTextField.text = ""
            qrImageView.image = nil
            qrcodeImage = nil
            generateButton.setTitle("Generate", for: UIControlState())
        }
        
        inputTextField.isEnabled = !inputTextField.isEnabled
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Custom method implementation
    func displayQRCodeImage() {
        
        let scaleX = qrImageView.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrImageView.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        qrImageView.image = convert(cmage: transformedImage)
        
    }
    
    
    func convert(cmage:CIImage) -> UIImage {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
}

