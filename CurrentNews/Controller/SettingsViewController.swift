//
//  SettingsViewController.swift
//  CurrentNews
//
//  Created by Marmago on 17/11/2020.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var languagePicker: UIPickerView!
    
    let languageArray = ["en","fr","es","de","ru","zh","ja","ar"]
    var viewController = ViewController()
    var language: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePicker.dataSource = self
        languagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

}
//MARK: - UIPickerViewDelegate & UIPickerviewDataSource
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageArray.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //navigationController?.popToRootViewController(animated: true)
        //UserDefaults.standard.setValue(languageArray[row], forKey: "Language")
        language = languageArray[row]
        self.performSegue(withIdentifier: K.rootSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.rootSegue{
            let destinationVC = segue.destination as! ViewController
            destinationVC.language = self.language!
            
        }
    }
    
}
