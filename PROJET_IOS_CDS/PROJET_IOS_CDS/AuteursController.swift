//KCHAOU Anis ,LAHLOU Mohammed

import UIKit
import Foundation


class AuteursController: UITableViewController ,XMLParserDelegate{
    
    //initlisation des proprietes
    var auteur = [String]()
    var titres = [[String]]()
    var auteur_titres = [String]()
    var auteur_tri = [String]()
    
    
    //initialication de vue
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //initialisation des tableau
        initialisation()
 
    }

    
    //callback en cas d'erreur dans la memoire
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

    
    
    //callback pour afficher les auteur (section)
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        //tri tableau auteur
        auteur_tri=auteur.sorted (by: {$0 < $1})
        
        return self.auteur_tri[section]
        
    }
    
    //changer la couleur de section
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
           
            headerView.textLabel?.textColor = .blue
        }
    }
    //callback pour nombre de section
    override func numberOfSections(in tableView: UITableView) -> Int {

        return self.auteur.count
        
    }
    
    
    //callback pour nombre de titre
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titres[section].count
        
    }
    
    
    //callback pour afficher les cellules de tableview
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //recuperer chaque cellule
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell")! as UITableViewCell
      
        //afficher le titre
        cell.textLabel?.text = self.titres[indexPath.section][indexPath.row]
       
        //retouner la cellule
        return cell
        
    }
   

    
    
   
    //initialisation des tableau
    private func initialisation()
    {
        //recuprer les depuis TitresController
        auteur = TitreController.auteur
        titres = TitreController.listetitreparauteur
        
    }
    
   
}

