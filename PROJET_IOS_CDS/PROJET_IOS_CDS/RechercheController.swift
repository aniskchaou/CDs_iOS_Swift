//KCHAOU Anis ,LAHLOU Mohammed

import UIKit

class RechercheController:  UIViewController ,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,XMLParserDelegate{
    
    
    
    
    //les champs tableau et seach bar
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    //listes
    static var titre_Array = [CDs]()
    static var current_titre_Array = [CDs]()
    var current_array_tri = [CDs]()
    
    //variable pour parser xml
    var thisname=String()
    static var titlecd = String()
    static var author = String()
    static var date = String()
    static var type = String()
    
    
    //callback si la vue est charge
    override func viewDidLoad() {
       
        //appel le constructeur de la classe mère
        super.viewDidLoad()
        
        //ouvrir le fichier xml
        if let path = Bundle.main.url(forResource: "CDs", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path)
            {
                parser.delegate=self
                parser.parse()
            }
        }
        
        //configuration de search bar
        searchbar.delegate=self
    }
    
    
    //callback en cas d'erreur memoire
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    
    
    //callback pour le nombre d'element dans uitableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return RechercheController.current_titre_Array.count
    }
    
   //callback pour afficher les cellules de uitable view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //recuprer la cellule
        guard let cell=tableView.dequeueReusableCell(withIdentifier: "Cell") as? CelluleController else{
        
       return   UITableViewCell()
        
        }
        
        //tri liste par nom des auteurs
         current_array_tri = RechercheController.current_titre_Array.sorted (by: {$0.auteur < $1.auteur})
       
        //afficher auteur et date
        cell.auteur.text=current_array_tri[indexPath.row].auteur
        cell.date.text=current_array_tri[indexPath.row].date
        cell.titre.text=current_array_tri[indexPath.row].titre
        //retourner la cellule
        return cell
        
    }
    
   
    //call back search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        guard !searchText.isEmpty else {RechercheController.current_titre_Array=RechercheController.titre_Array
            table.reloadData()
            return }
        
        //filtrer la lites des titres
        RechercheController.current_titre_Array=RechercheController.titre_Array.filter({music->Bool in

            return music.auteur.lowercased().contains(searchText.lowercased())
            
        })
        
        //retouner le table
        table.reloadData()
        
    }
   
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope{
        
        //filtre tous
        case 0:
            RechercheController.current_titre_Array=RechercheController.titre_Array
       break
        //filtre rock
        case 1:
            RechercheController.current_titre_Array=RechercheController.titre_Array.filter({
                music->Bool in
                music.type == TypeMusique.rock
                
            })
        break
      
        //metal
        case 2:
            RechercheController.current_titre_Array=RechercheController.titre_Array.filter({
                music->Bool in
                music.type == TypeMusique.metal
            })
            break
        
        //filtre pop
        case 3:
            RechercheController.current_titre_Array=RechercheController.titre_Array.filter({
                music->Bool in
                music.type == TypeMusique.pop
            })
            break
            
        default:
            break
            
            
        }
        //recharger table view
        table.reloadData()
    }
    
   
    
    
    
    
    
    
    //callback parser xml
    func parser(_ parser: XMLParser, foundCharacters string: String) {
      
        //recuprer la ligne dans le document xml
        let xml=XMLController()
        xml.parserRecherche(thisname: thisname,string: string)
    }
    
    
    //callback debut parsing
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
       
        //recuprer chaque balises
        thisname = elementName
       
    }
    
    //callback fin parsing
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let xml=XMLController()
        xml.finirParserRecherche(elementName:elementName)
    }

}

    

