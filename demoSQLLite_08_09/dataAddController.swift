
import UIKit

class dataAddController: UIViewController {
    
    var databasePath = String()
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDB()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        if txtName.text?.characters.count == 0 && (txtCity.text?.characters.count)! == 0{
            print("Enter Proper data")
            return
        }
        else{
            var myName = txtName.text!
            myName = myName.replacingOccurrences(of: "'", with: "\''")
            
            var myCity = txtCity.text!
            myCity = myCity.replacingOccurrences(of: "'", with: "\''")
            
            self.insertData(myName, myCity)
        }
    }
    
    func createDB() -> Void {
        let strURL = "CREATE TABLE IF NOT EXISTS DEMOSQL (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, CITY TEXT)"
        print(strURL)
        
        let data = AFSQLWrapper.createTable(strURL)
        print(data)
    }
    
    func insertData(_ myName: String, _ myCity: String) -> Void {
        let strURL = "INSERT INTO DEMOSQL (NAME, CITY) VALUES ('\(myName)', '\(myCity)')"
        print(strURL)
        
        let data = AFSQLWrapper.insertTable(strURL)
        print(data)
        if data.Status == 1{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "dataShowController") as? dataShowController
            self.navigationController!.pushViewController(vc!, animated: true)
        }
    }
    
}
