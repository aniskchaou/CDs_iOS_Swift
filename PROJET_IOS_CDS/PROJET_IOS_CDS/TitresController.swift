//KCHAOU Anis , LAHLOU Mohammed

import UIKit

class TitreController:UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate {

    //liste
    @IBOutlet weak var liste_cds: UITableView!
    
        
    //tableau d'auteur et de listes des auteurs de type static utilisés apres pour afficher les titres par auteurs
    static var auteur_titres = [String]()
    static var listetitreparauteur=[[String]]()
    static var auteur = [String]()
    static var tableViewDataSource=[CDs]()
     var table_tri=[CDs]()
    
    //initiation des variables
    var thisname = String()
    static var titlecd = String()
    static var author = String()
    static var date = String()


    //initialication de vue
    override func viewDidLoad() {
       
        //appele le constructeur de la classe mere
        super.viewDidLoad()
        
     
        
        //configuration de la liste
        liste_cds.dataSource=self
        liste_cds.delegate=self
        
      
        //lire le fichier xml
        if let path = Bundle.main.url(forResource: "CDs", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path)
            {
                //parser le document
                parser.delegate=self
                parser.parse()
            }
        }
        

    }
    
    //callback en cas de probleme dans la memoire
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
           }
    
    
    //callback tableview pour construire chaque cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //identification de cellule
        let mycell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //identification des labels
        let titlee = mycell.viewWithTag(100) as! UILabel
        let authorr = mycell.viewWithTag(300) as! UILabel
        let date = mycell.viewWithTag(200) as! UILabel
        
        //tri tableau
        table_tri=TitreController.tableViewDataSource.sorted (by: {$0.titre < $1.titre})
        
        //ecrire dans les labels
       
        
        //afficher titre auteur date
        titlee.text=table_tri[indexPath.row].titre
        authorr.text=table_tri[indexPath.row].auteur
        date.text=table_tri[indexPath.row].date
        
        
        //retouner la cellule
        return mycell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            
         
            var alert = UIAlertController(title: "Confirmation ?", message:
                "Voulez vous supprimer cet titre ?", preferredStyle: UIAlertControllerStyle.alert)
            
            self.present(alert, animated: false, completion: nil)
            
            alert.addAction(UIAlertAction(title: "Non", style: UIAlertActionStyle.default,
                                          handler: nil))
            alert.addAction(UIAlertAction(title: "Oui", style: .default, handler:
                {action in
                    
                    //supprimer ligne depuis le tableau
                    TitreController.tableViewDataSource.remove(at: indexPath.row)
                    
                    self.table_tri=TitreController.tableViewDataSource.sorted (by: {$0.titre < $1.titre})
                    
                    //supprimer ligne depuis la vue
                    self.liste_cds.deleteRows(at: [indexPath as IndexPath], with: .fade)
                    
                    //alert
                    let alert = UIAlertView()
                    alert.title = "Info !"
                    alert.message = "Le titre est supprimé avec succés."
                    alert.addButton(withTitle: "OK")
                    alert.show()
                    
            }))
            //recharger la liste
            //liste_cds.reloadData()
        }
    
    }
    
    
    
    
    //callback pour le nombre d'element dans tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TitreController.tableViewDataSource.count
    }

    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
      
        //parser xml
        let xml=XMLController()
        xml.parser(thisname: thisname,string: string)
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //recuprer la balise
        thisname = elementName

    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //finir parser
     let xml=XMLController()
        xml.finirParser(elementName:elementName)
    }}

