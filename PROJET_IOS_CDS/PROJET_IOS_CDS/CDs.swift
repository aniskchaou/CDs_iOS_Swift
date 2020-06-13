//KCHAOU Anis ,LAHLOU Mohammed

import Foundation

class CDs{
    
    //liste de proprietes
    var titre:String
    let image:String
    var date:String
    let options:String
    var type:TypeMusique
    var auteur:String
    
    //constucteurs
    
    init() {
        self.titre=""
        self.date=""
        self.type=TypeMusique.pop
        self.image=""
        self.auteur=""
        self.options=""
    }
    
    init(titre:String,type : TypeMusique,date:String,image:String,auteur:String,options:String) {

        self.titre=titre
        self.date=date
        self.type=type
        self.image=image
        self.auteur=auteur
        self.options=options
    }
    
    

}

//enumeration pour le type de musique
enum TypeMusique:String{
    case pop="pop"
    case rock="rock"
    case metal="metal"
    
}
