//
//  ViewController.swift
//  ImaGestures
//
//  Created by DCS on 05/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit
 private var flag = 1
class ViewController: UIViewController {
    
    private let myimg : UIImageView = {
        let img = UIImageView()
         img.frame = CGRect(x: 100, y: 150, width: 200, height: 200)
        return img
        
    }()
    private let imagePicker:UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    private let textview : UILabel = {
        let txt = UILabel()
        txt.text = "Tab and Select The Image "
        txt.textColor = .gray
         txt.frame = CGRect(x: 20, y: 300, width: 350, height: 40)
        txt.textAlignment = .center
        return txt
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(myimg)
       view.addSubview(textview)
         imagePicker.delegate = self
        let tab = UITapGestureRecognizer(target: self, action: #selector(openImagepicker))
        view.addGestureRecognizer(tab)
    
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(Didpinch))
        view.addGestureRecognizer(pinch)
        let Rotation = UIRotationGestureRecognizer(target: self, action: #selector(Didrotation))
        view.addGestureRecognizer(Rotation)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Didswipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Didswipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Didswipe))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Didswipe))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(Didpan))
        view.addGestureRecognizer(pan)
    }
    

}
extension ViewController {
    @objc private func openImagepicker(_ gesture:UITapGestureRecognizer){
        if (flag == 1){
        imagePicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true)
        }
        }else{
            print("only tab")
        }
    }
    @objc private func Didpinch(_ gesture:UIPinchGestureRecognizer){
        myimg.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    @objc private func Didrotation(_ gesture:UIRotationGestureRecognizer){
        myimg.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    @objc private func Didswipe(_ gesture:UISwipeGestureRecognizer){
        
        if gesture.direction == .left   {
            UIView.animate(withDuration: 0.2){
                self.myimg.frame = CGRect(x: self.myimg.frame.origin.x - 50, y: self.myimg.frame.origin.y, width: 200, height: 200)
            }
        }else if gesture.direction == .right   {
            UIView.animate(withDuration: 0.2){
                self.myimg.frame = CGRect(x: self.myimg.frame.origin.x + 50, y: self.myimg.frame.origin.y, width: 200, height: 200)
            }
        }
        else if gesture.direction == .up   {
            UIView.animate(withDuration: 0.2){
                self.myimg.frame = CGRect(x: self.myimg.frame.origin.x, y: self.myimg.frame.origin.y - 50 , width: 200, height: 200)
            }
        }
        else if gesture.direction == .down   {
            UIView.animate(withDuration: 0.2){
                self.myimg.frame = CGRect(x: self.myimg.frame.origin.x, y: self.myimg.frame.origin.y + 50 , width: 200, height: 200)
            }
        }
    }
    @objc private func Didpan(_ gesture:UIPanGestureRecognizer){
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        myimg.center = CGPoint(x: x, y: y)
    }
}
extension ViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            myimg.image = selectedImage
        }
        
        picker.dismiss(animated: true)
        flag = 0
        textview.isHidden = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
