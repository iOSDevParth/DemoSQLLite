

import UIKit

class dataShowController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblDataList: UITableView!
    var globalID = 0
    var arrLocalData = NSMutableArray()
    var dictData = NSMutableDictionary()
    var databasePath = String()
    var ID = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.showData()
    }
    
    func showData() {
        let strURL = "SELECT * FROM DEMOSQL"
        print(strURL)
        arrLocalData.removeAllObjects()
        let data = AFSQLWrapper.selectTable(strURL)
        print(data)
        if data.Status == 1 {
            arrLocalData = data.arrData
            tblDataList.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLocalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell") as! ViewCell
        cell.lblName.text = (arrLocalData.object(at: indexPath.row) as AnyObject).value(forKey: "NAME") as? String
        
        cell.lblCity.text = (arrLocalData.object(at: indexPath.row) as AnyObject).value(forKey: "CITY") as? String
        
        cell.btnDelete.addTarget(self, action: #selector(btnDelete), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        globalID = ((arrLocalData.object(at: indexPath.row) as! NSObject).value(forKey: "ID") as? Int)!
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "dataUpdateController") as? dataUpdateController
        vc!.globalId = globalID
        self.navigationController!.pushViewController(vc!, animated: true)
        
        print("Global Id---",globalID)
    }
    
    func btnDelete(sender: UIButton)
    {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tblDataList)
        let indexPath = self.tblDataList.indexPathForRow(at: buttonPosition)
        if indexPath != nil
        {
            ID = ((arrLocalData.object(at: (indexPath?.row)!) as! NSObject).value(forKey: "ID") as? Int)!
            print(ID)
            let strURL = "DELETE FROM DEMOSQL where ID='\(ID)'"
            print(strURL)
            
            let data = AFSQLWrapper.deleteDataTable(strURL)
            print(data)
            if data.Status == 1 {
                showData()
            }
            
        }
    }
}
