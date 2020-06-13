// KCHAOU Anis ,LAHLOU Mohammed
import Foundation

class XMLController
{


    
     func parser(thisname:String,string : String)
    {
        //recuperer une ligne
        let data=string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        //tant que chaque ligne n'est pas vide
        if data.characters.count != 0
        {
            //selon le nom de la balise initiliser auteur et titre cd et date
            switch thisname {
            case "author":
                TitreController.author = data
            case "title":
                TitreController.titlecd = data
            case "date":
                TitreController.date = data
            default:
                break
            }
        }    }
    
    
    func finirParser(elementName:String)
    {
        
        if elementName=="cd"
        {
            //instantialisation de modele et initialisation des proprietes
            let cd = CDs()
            cd.titre=TitreController.titlecd
            cd.auteur=TitreController.author
            cd.date=TitreController.date
            
            
            //ajouter dans la liste
            TitreController.tableViewDataSource.append(cd)
            
            //ajouter auteur/titre
            TitreController.auteur_titres.append(TitreController.author+"/"+TitreController.titlecd)
            
            //ajouter auteur
            TitreController.auteur.append(TitreController.author)
            
            
            //pour chaque auteur
            for item in TitreController.auteur {
                
                //initialisation tableau de titre
                var titre = [String]()
                
                //pour chaque auteur titre
                for item2 in TitreController.auteur_titres{
                    
                    //faire un split avec delimiteur / pour recuprer les titre de chaque auteur
                    let splt = item2.components(separatedBy: "/")
                    
                    //recuprer titre et auteur
                    let author    = splt[0]
                    let title = splt[1]
                   
                    //comparer auteur avec la listes des auteur
                    if author==item
                    {
                        //ajouter la liste des auteur
                        titre.append(title)
                        
                        
                        
                    }
                }
                
                //ajouter le tableau dans un autre tableau
                TitreController.listetitreparauteur.append(titre)
            }
            
            
        }        
    }
    
    
    func lireXMLTitreController(delege:TitreController)
    {
        //lire le fichier xml
        if let path = Bundle.main.url(forResource: "CDs", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path)
            {
                //parser le document
                parser.delegate=delege
                parser.parse()
            }
        }
    
    }
    
    
    func parserRecherche(thisname:String,string : String)
    {
        //recuperer une ligne
        let data=string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        //tant que chaque ligne n'est pas vide
        if data.characters.count != 0
        {
            //selon le nom de la balise initiliser auteur et titre cd et date
            switch thisname {
            case "author":
                RechercheController.author = data
            case "title":
                RechercheController.titlecd = data
            case "date":
                RechercheController.date = data
            case "options":
                RechercheController.type = data
            default:
                break
            }
        }
    }
    
    func finirParserRecherche(elementName:String)
    {
        
        if elementName=="cd"
        {
            //instantialisation de modele et initialisation des proprietes
            let cd = CDs()
            cd.titre=RechercheController.titlecd
            cd.auteur=RechercheController.author
            cd.date=RechercheController.date
           
            //type musique
            if RechercheController.type=="pop" {
                cd.type = TypeMusique.pop
               
                
            }
            
            if RechercheController.type=="rock" {
                cd.type = TypeMusique.rock
            }
           
            if RechercheController.type=="metal" {
                cd.type = TypeMusique.metal
            }
            
            //ajouter la liste
            RechercheController.titre_Array.append(cd)
            RechercheController.current_titre_Array.append(cd)
            
            
            
        }
    }
}
