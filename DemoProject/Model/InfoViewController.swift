

import UIKit
import CoreData
import SideMenu
import GoogleSignIn
class InfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UISearchBarDelegate,UISearchDisplayDelegate, MenuControllerDelegate
{
    private var sideMenu: SideMenuNavigationController?

   
    
    var isSideViewOpen:Bool = false
  
    var people: [NSManagedObject] = []
    
    
    @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var SearchBar: UISearchBar!
    var userModel:UserModel?
    
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
  
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
    title = "The Lost List"
                 let menu = MenuController(with: SideMenuItem.allCases)
                   menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
                          sideMenu?.leftSide = true

                          SideMenuManager.default.leftMenuNavigationController = sideMenu
                   
                          SideMenuManager.default.addPanGestureToPresent(toView: view)

                     
                   
                   
                  sideMenu?.setNavigationBarHidden(true, animated: false)
                  
                   
                   
                   
               self.navigationItem.setHidesBackButton(true, animated: false)
        
 
    
    
    }
    
    
    @IBAction func didTapp(_ sender: Any) {
        
        present(sideMenu! ,animated:  true)
    }
    
  
    

     func didSelectMenuItem(named: SideMenuItem) {
         sideMenu?.dismiss(animated: true, completion: nil)

      
         switch named {
            
         case .home:
           
            
           let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sam = sigt.instantiateViewController(withIdentifier: "CustomTable") as! CustomTableViewController
             
             
       navigationController?.pushViewController(sam, animated: false)
           
         case .lost:
             
             let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let sam = sigt.instantiateViewController(withIdentifier: "infoo") as! InfoViewController
                        
                        
                    navigationController?.pushViewController(sam, animated: false)
             
      

         case .found:
             
             let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let sam = sigt.instantiateViewController(withIdentifier: "helloo") as! SettingsViewController
                        
                        
                    navigationController?.pushViewController(sam, animated: false)
             
            
          
         }

     }
    
   
             
            

         
    
    
    
    
    
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return people.count
    }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let person = people[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      cell.textLabel?.text = person.value(forKeyPath: "name") as? String
      return cell
    }
 override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let managedContext = appDelegate!.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")

    do {
      people = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)

    let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in

      guard let textField = alert.textFields?.first,
        let nameToSave = textField.text else {
          return
      }

      self.save(name: nameToSave)
      self.tableView.reloadData()
    }

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alert.addTextField()
    alert.addAction(saveAction)
    alert.addAction(cancelAction)

    present(alert, animated: true)
  }

  func save(name: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
    let person = NSManagedObject(entity: entity, insertInto: managedContext)
    person.setValue(name, forKeyPath: "name")

    do {
      try managedContext.save()
      people.append(person)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""
        {
            
            var predicate: NSPredicate = NSPredicate()
            predicate = NSPredicate(format: " name contains[c] '\(searchText)'")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
             let context = appDelegate.persistentContainer.viewContext
            let fetchreq = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            fetchreq.predicate = predicate
            do{
                people = try context.fetch(fetchreq) as! [NSManagedObject]
                
                
            }
            catch{
                
                print("no data")
            }
        }
        else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchreq = NSFetchRequest<NSManagedObject>(entityName: "Person")
            do{
                    people = try context.fetch(fetchreq)
                    
                    
                }
                catch{
                    
                    print("no data")
                }
            
        }
        tableView.reloadData()
    }
    
    
}
    




