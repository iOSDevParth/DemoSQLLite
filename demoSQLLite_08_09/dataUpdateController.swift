

import UIKit

class dataUpdateController: UIViewController {
    
    @IBOutlet weak var txtNameNew: UITextField!
    @IBOutlet weak var txtCityNew: UITextField!
    var globalId = Int()
    var arrLocalData = NSMutableArray()
    var databasePath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDataUpdate()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnUpdateDataClick(_ sender: UIButton) {
        self.updateData()
    }
    
    func showDataUpdate() {
        let strURL = "SELECT * FROM DEMOSQL where ID='\(globalId)'"
        print(strURL)
        
        let data = AFSQLWrapper.selectIdDataTable(strURL)
        print(data)
        if data.Status == 1 {
            arrLocalData = data.arrData
            txtNameNew.text = (arrLocalData.object(at: 0) as AnyObject).value(forKey: "NAME") as? String
            
            txtCityNew.text = (arrLocalData.object(at: 0) as AnyObject).value(forKey: "CITY") as? String
        }
        
    }
    
    func updateData(){
        
        let strURL = "update DEMOSQL set NAME='\(txtNameNew.text!)', CITY='\(txtCityNew.text!)' where ID='\(globalId)'"
        print(strURL)
        
        let data = AFSQLWrapper.updateTable(strURL)
        print(data)
        if data.Status == 1 {
            txtCityNew.text = ""
            txtNameNew.text = ""
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "dataShowController") as? dataShowController
            self.navigationController!.pushViewController(vc!, animated: true)
        }
    }
}
