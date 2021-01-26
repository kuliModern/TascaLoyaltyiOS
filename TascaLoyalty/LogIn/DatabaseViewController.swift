//
//  DatabaseViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 21/01/21.
//

import UIKit
import Alamofire


class DatabaseViewController: UIViewController {
   
    
    
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var namaUser: UITextField!
    @IBOutlet weak var nomerTelfonUser: UITextField!
    @IBOutlet weak var passwordUser: UITextField!
    
    
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var lanjutButton: UIButton!
    private var datePicker: UIDatePicker?
    
    
    
    
    var genderArray = Gender()
    var genderPick = ""
    var birthdate = ""
    var tokenID: String = ""
    
    override func viewDidLoad() {
       
        // Tombol lanjut
        lanjutButton.alpha = 0
        namaUser.delegate = self
        // Date Picker
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker!.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dataChange(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapGesture(gestureRecognize:)))
        
        view.addGestureRecognizer(tapGesture)
       
        birthDate.inputView = datePicker
       
        // Gender Picker
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        //
        
        // Do any additional setup after loading the view.
       
  
    }
    
    @IBAction func lanjutPressed(_ sender: UIButton) {
        print("------")
        print(genderPick)
        print(birthdate)
        print(namaUser.text!)
        print(passwordUser.text!)
        print(nomerTelfonUser.text!)
        print(tokenID)
        print("------")
        let name = namaUser.text!
        let birthday = birthdate
        let gender = self.genderPick
        let password = passwordUser.text!
        let phone = nomerTelfonUser.text!

        
     

        let urlString   = "https://c5d33bab53d9.ngrok.io/api/editdata"
        let parameters  = ["name": name,
                           "birthday": birthday,
                           "gender": gender,
                           "password": password,
                           "phone_number": phone
        ]
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
                                     "Authorization": "Bearer \(tokenID)"
        
        ]

        AF.request(urlString, method: .put, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
          switch response.result {
          case .success:
           
            
            print("Validation Successful")
            print(response)
            
          case let .failure(error):
            
            print(error)
           
          }
            
        }
        
       
    }
    @objc func tapGesture(gestureRecognize: UIGestureRecognizer) {
        view.endEditing(true)
        print(birthDate.text!)
        birthdate = birthDate.text!
       
    }
    

    @objc func dataChange(datePicker: UIDatePicker){
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        
        birthDate.text = dateFormat.string(from: datePicker.date)
  
        
    }
}
// MARK: - UITextDelegate buat Lanjut ilang
extension DatabaseViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        namaUser.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        lanjutButton.alpha = 1
        return true
    }
   
}
// MARK: - Pilih Gendernya
    extension DatabaseViewController: UIPickerViewDelegate, UIPickerViewDataSource{
        
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderArray.gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genderArray.gender[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        genderPick = genderArray.gender[row]
        print(genderPick)
       
    }
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


   

