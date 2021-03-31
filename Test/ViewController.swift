//
//  ViewController.swift
//  Test
//
//  Created by user188220 on 3/16/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Controller
        let requestFactory = RequestFactory()

        requestFactory.getFurnitureList { (errorHandle, furnitures) in
            if
                let _ = errorHandle.errorType, let errorMessage =
                    errorHandle.errorMessage {
                print(errorMessage)
                
            }else if let list = furnitures, let furniture = list.last {
                print(furniture.id)
                
            }else {print("Houston we got a problem")    }
            
        }

        requestFactory.deleteFurniture(with: "keyZoaahVuD0KvuoM") { (errorHandle, response) in
            if let _ = errorHandle.errorType, let errorMessage = errorHandle.errorMessage {
                print(errorMessage)
                
            }
            else if let reponse = response {
                print(reponse.deleted)

                
            }
            else {print("Houston we got a problem")
                
            }
            
        }
    }


}

