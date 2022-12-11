    //
    //  ViewController.swift
    //  CoreDataDemo
    //
    //  Created by user on 12/11/2022.
    //

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var btnUserName: UITextField!
    @IBOutlet weak var btnEmail: UITextField!
    @IBOutlet weak var btnPassword: UITextField!
    @IBOutlet weak var btnPhoneNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        storeData()
    }
    
    @IBAction func RetreiveBtnTapped(_ sender: UIButton) {
        retrieveData()
    }
    
    fileprivate func clearInputFields() {
        btnUserName.text = ""
        btnEmail.text = ""
        btnPassword.text = ""
        btnPhoneNumber.text = ""
    }
    
    func storeData(){
            // Refer to the container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
            // Connect with Entity
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
            // Create record
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue("\(btnUserName.text!)", forKey: "username")
        user.setValue("\(btnEmail.text!)", forKey: "email")
        user.setValue("\(btnPassword.text!)", forKey: "password")
        user.setValue(Int(btnPhoneNumber.text!), forKey: "phone")
        
            // Save to the entity
        do{
            try managedContext.save()
            print("Saved successfully.")
            clearInputFields()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func retrieveData(){
            // Refer the container
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appdelegate.persistentContainer.viewContext
            // Connect with Entity for reading
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                for data in result as! [NSManagedObject]{
                    print(data.value(forKey: "username"))
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}

